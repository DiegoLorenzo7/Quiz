//
//  ScoresModel.swift
//  Quiz
//
//  Created by c078 DIT UPM on 21/12/23.
//

import Foundation
@Observable class ScoresModel{
    var acertadas: Set<Int> = []
    var record: Set<Int> = []
    init() {
      let a = UserDefaults.standard.object(forKey: "record") as? [Int] ?? []
                record = Set(a)
                
    }
    func check(quizItem: QuizItem, answer: String) {
        
    }
    
    func add(quizItem: QuizItem){
        acertadas.insert(quizItem.id)
        record.insert(quizItem.id)
        
        UserDefaults.standard.set(Array(record), forKey: "record")
        
        UserDefaults.standard.synchronize()

    }
    func pendiente(_ quizItem: QuizItem) -> Bool {
        !acertadas.contains(quizItem.id)
    }
    func cleanup(){
        acertadas = []
    }
}
