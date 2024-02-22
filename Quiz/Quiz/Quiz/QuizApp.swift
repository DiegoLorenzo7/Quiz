//
//  QuizApp.swift
//  Quiz
//
//  Created by c078 DIT UPM on 21/12/23.
//

import SwiftUI

@main

struct QuizApp: App {
    
    @State var quizzesModel: QuizzesModel = QuizzesModel()
    @State var scoresModel: ScoresModel = ScoresModel()
    
    
    var body: some Scene {
        WindowGroup {
            QuizzesListView()
                .environment(quizzesModel)
                .environment(scoresModel)
        }
    }
    
}
