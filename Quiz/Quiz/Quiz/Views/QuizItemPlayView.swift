//
//  QuizItemPlayView.swift
//  Quiz
//
//  Created by c078 DIT UPM on 21/12/23.
//

import Foundation
import SwiftUI

struct QuizItemPlayView: View {

    @Environment(QuizzesModel.self) var quizzesModel

    @Environment(ScoresModel.self) var scoresModel

    @Environment(\.verticalSizeClass) var vsc

    var quizItem: QuizItem

    @State var answer: String = ""
    @State var showCheckAlert = false

    @State var errorMsg = "" {
        didSet {
            showErrorMsgAlert = true
        }
                 }
    @State var showErrorMsgAlert = false
    @State var checkingResponse = false
    @State var answerIsOk = false
    
    
    var body: some View {
        VStack {
            titulo
            
            if vsc == .compact {
                HStack(spacing:10) {
                    VStack {
                        Spacer()
                        pregunta
                        Spacer()
                        HStack {
                            puntos
                            Spacer()
                            autor
                        }
                    }
                    adjunto
                }
            }else {
                

                VStack {
               Spacer()
               pregunta
               Spacer()
               adjunto
               Spacer()
               HStack {
                   puntos
                   Spacer()
                   autor
               }
            }
        }
    }
        .alert("Error",
                       isPresented: $showErrorMsgAlert) {
                           
                       }message: { Text(errorMsg)
                       }
                .navigationTitle("Playing")
               }
               

               private var puntos: some View {
                   Text("\(scoresModel.acertadas.count)")
                       .font(.title)
                       .fontWeight(.bold)
                       .foregroundStyle(.pink)
               }
               
               private var pregunta: some View {
                   VStack {
                       TextField("respuesta", text: $answer)
                           .textFieldStyle(.roundedBorder)
                           .onSubmit {
                               Task{
                                   await checkResponse()
                               }
                           }
                       if checkingResponse {
                           ProgressView()
                       }else {
                           Button("Comprobar") {
                               Task {
                                   await checkResponse()
                               }
                           }
                       }
                   }
                   .alert("Resultado",
                          isPresented: $showCheckAlert){
                   } message: {
                       Text(answerIsOk ? "¡Respuesta correcta!" : "Respuesta incorrecta :(")
                   }
               }

               private var titulo: some View {
                   HStack {
                       Text(quizItem.question)
                           .font(.title)
                           .fontWeight(.bold)
                       Spacer()
                       Button{
                           Task {
                               do {
                                   try await quizzesModel.toggleFavourite(quizItem: quizItem)
                               } catch {
                                   errorMsg = error.localizedDescription
                               }
                           }
                       } label: {
                           Image(quizItem.favourite ? "star_amarilla" : "star_gris")
                       }
                   }
               }
               
               private var adjunto: some View {
                   GeometryReader { g in
                       MyAsyncImage(url: quizItem.attachment?.url)
                           .saturation(showCheckAlert ? 0 : 1)
                           .rotationEffect(Angle(degrees: showCheckAlert ? 180 : 0))
                           .animation(.easeInOut, value : showCheckAlert)
                           .scaledToFill()
                           .frame(width: g.size.width, height: g.size.height)
                           .clipShape (RoundedRectangle(cornerRadius: 25.0))
                           .contentShape(RoundedRectangle(cornerRadius: 25.0))
                           .overlay {
                               RoundedRectangle(cornerRadius: 25.0).stroke(Color.blue, lineWidth: 2)
                           }
                           .shadow(color: .blue, radius : 6, x: 0.0, y: 0.0)
                   }
               }
               
    private var autor: some View {
        HStack {
            Spacer()
            Text(quizItem.author?.username ??
                 quizItem.author?.profileName ?? "Nose")
            MyAsyncImage(url: quizItem.author?.photo?.url)
                .frame(width: 30, height: 30)
                .scaledToFill()
                .clipShape (Circle())
                .overlay {
                    Circle().stroke(Color.blue, lineWidth: 2)
                }
                .shadow(color: .blue, radius: 6, x: 0.0, y: 0.0)
                .contextMenu(menuItems: {
                    Button(action: {
                        answer = ""
                    }, label: {
                        Label("Limpiar", systemImage: "x.circle")
                    })
                    Button(action: {
                        answer = "Pepe"
                    }, label: {
                        Label("Solución", systemImage: "figure.kickboxing")
                    })
                })
        }
    }
    


               func checkResponse() async {
                   do {
                       checkingResponse = true
                       
                       answerIsOk = try await quizzesModel.check(quizItem: quizItem, answer: answer)
                       
                       showCheckAlert = true
                       if answerIsOk{
                           scoresModel.add(quizItem: quizItem)
                       }
                       
                       
                       checkingResponse = false
                   } catch {
                       errorMsg = error.localizedDescription
                   }
                   
               }
               }
