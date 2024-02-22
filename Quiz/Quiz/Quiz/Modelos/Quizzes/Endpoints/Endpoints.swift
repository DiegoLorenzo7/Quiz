//
//  Endpoints.swift
//  Quiz
//
//  Created by c078 DIT UPM on 21/12/23.
//

import Foundation
let urlBase = "https://quiz.dit.upm.es"
let token = "c15c30caedb99c06d2e0"
struct Endpoints {
    static func random10() -> URL? {
        let path = "/api/quizzes/random10"
        let str = "\(urlBase)\(path)?token=\(token)"
        return URL(string: str)
    }
    
    static func checkAnswer(quizItem: QuizItem, answer: String) -> URL? {
        let path = "/api/quizzes/\(quizItem.id)/check"
        
        guard let escapedAnswer = answer.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {return nil}
        
        let str = "\(urlBase)\(path)?answer=\(escapedAnswer)&token=\(token)"
        return URL(string: str)
    }
    
    static func toggleFav(quizItem: QuizItem) -> URL? {
        
        let path="/api/users/tokenOwner/favourites/\(quizItem.id)"
        
        let str = "\(urlBase)\(path)?token=\(token)"
        return URL(string: str)
    }
}
