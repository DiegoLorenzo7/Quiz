//
//  QuizItemRowView.swift
//  Quiz
//
//  Created by c078 DIT UPM on 21/12/23.
//

import Foundation
import SwiftUI

struct QuizItemRowView: View {
    var quizItem: QuizItem
    var body: some View {
        HStack() {
            MyAsyncImage(url: quizItem.attachment?.url)
                .frame(width: 60,height: 60)
                .scaledToFill()
                .clipShape(RoundedRectangle(cornerRadius: 100))
                .overlay{
                    Circle().stroke(Color.yellow, lineWidth: 4)
                }
                .shadow(color: .blue, radius: 5, x: 0.0, y: 0.0)
            
            Text(quizItem.question)
                .font(.title)
            Spacer()
            VStack(alignment: .center) {
                Image(quizItem.favourite ? "star_amarilla" : "star_gris")
                    .resizable()
                    .frame(width: 32.0, height: 32.0)
            }
            MyAsyncImage(url: quizItem.author?.photo?.url)
                .frame(width: 30,height: 30)
                .scaledToFill()
                .clipShape(RoundedRectangle(cornerRadius: 100))
                .overlay{
                    Circle().stroke(Color.yellow, lineWidth: 4)
                }
                .shadow(color: .blue, radius: 5, x: 0.0, y: 0.0)
        }
        .padding()
    }
}
