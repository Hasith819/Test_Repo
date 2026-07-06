//
//  TriviaQuestion.swift
//  ios-project
//
//  Created by student6 on 2026-07-05.
//

import Foundation

struct TriviaQuestion: Codable, Identifiable {
    let id = UUID()
    let question: String
    let correct_answer: String
    let incorrect_answers: [String]

    enum CodingKeys: String, CodingKey {
        case question
        case correct_answer
        case incorrect_answers
    }
}