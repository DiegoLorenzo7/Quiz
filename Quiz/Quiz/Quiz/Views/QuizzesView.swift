//
//  QuizzesView.swift
//  Quiz
//
//  Created by c078 DIT UPM on 21/12/23.
//

import Foundation
struct QuizzesView: View{
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
                            QuizPlayView(quizItem: quizItem)
                        } label: {
                            QuizRow(quizItem: quizItem)
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
