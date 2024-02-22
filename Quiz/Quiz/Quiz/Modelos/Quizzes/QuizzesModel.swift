//
//  QuizzesModel.swift
//  Quiz
//
//  Created by c078 DIT UPM on 21/12/23.
//

import Foundation
@Observable class QuizzesModel{
    
    // Los datos
    private(set) var quizzes = [QuizItem]()
    
    func download() async throws {
        guard let url = Endpoints.random10() else {
            throw "Fallos piratas, mas tarde"
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw "No bebes no quizzes"
        }
        
        guard let quizzes = try? JSONDecoder().decode([QuizItem].self, from: data) else {
            throw "Recibidos datos corruptos."
        }
        self.quizzes = quizzes
        print("Quizzes cargados")
    }
    
    func check(quizItem: QuizItem, answer: String) async throws -> Bool {
        
        guard let url = Endpoints.checkAnswer(quizItem: quizItem, answer: answer) else { throw "No puedo comprobar la respuesta"
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw "No bebes no quizzees"
        }
        // printi ("Quizzes ==>", String(data: data, encoding: String.Encoding.utf8) ?? "JSON incorrecto")
        
        guard let res = try? JSONDecoder().decode(CheckResponseItem.self, from: data) else { throw "Recibidos datos corruptos."
        }
        return res.result
    }
    func toggleFavourite(quizItem: QuizItem) async throws {
        guard let url = Endpoints.toggleFav(quizItem: quizItem) else {
            throw "No puedo comprobar la respuesta"
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = quizItem.favourite ? "DELETE": "PUT"
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw "No bebes no quizzees"
        }
        guard let res = try? JSONDecoder().decode(FavouriteStatusItem.self, from: data) else {
            throw "Recibidos datos corruptos."
        }
        guard let index = quizzes.firstIndex(where: {qi in qi.id == quizItem.id}) else {
            throw "uf"
        }
        quizzes[index].favourite = res.favourite
    }
}
