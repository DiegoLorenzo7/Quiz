//
//  CheckResponseItem.swift
//  Quiz
//
//  Created by c078 DIT UPM on 21/12/23.
//

import Foundation
struct CheckResponseItem: Codable {
    let quizId: Int
    let answer: String
    let result: Bool
}
