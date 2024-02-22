//
//  QuizzesListView.swift
//  Quiz
//
//  Created by c078 DIT UPM on 21/12/23.
//

import Foundation
import SwiftUI

struct QuizzesListView: View{
    @Environment(QuizzesModel.self) var quizzesModel
    @Environment(ScoresModel.self) var scoresModel
    
    @State var errorMsg = "" {
        didSet {
            showErrorMsgAlert = true
        }
    }
    
    @State var showErrorMsgAlert = false
    @State var showAll = true
    
    var body: some View {
        NavigationStack {
            List {
                Toggle("Ver Todos", isOn: $showAll)
                ForEach(quizzesModel.quizzes) { quizItem in
                    if showAll || scoresModel.pendiente(quizItem) {
                        NavigationLink {
                            QuizItemPlayView(quizItem: quizItem)
                        } label: {
                            QuizItemRowView(quizItem: quizItem)
                        }
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("P4 Quizzes")
            .navigationBarItems(
                leading: Text("record = \(scoresModel.record.count)"),
                trailing: Button(action: {
                                    Task {
                                        do {
                                            try await quizzesModel.download()
                                            scoresModel.cleanup()
                                        } catch {
                                            errorMsg = error.localizedDescription
                                        }
                                    }
                                    
                                }, label: {
                                    Label("Refrescar", systemImage: "arrow.counterclockwise")
                                }))
                        }
                        .alert("Error", isPresented: $showErrorMsgAlert) {
                        } message: {Text(errorMsg)
                        }
                        .task{
                            do {
                                guard quizzesModel.quizzes.count == 0 else {return}
                                try await quizzesModel.download()
                            } catch {
                                errorMsg = error.localizedDescription
                            }
                        }
                        .padding()
                    }
                }
