//
//  GameMode.swift
//  ios-project
//
//  Created by student6 on 2026-07-05.
//

import Foundation

enum GameMode: String, Codable, CaseIterable, Identifiable {
    case tapFrenzy = "Tap Frenzy"
    case lightItUp = "Light It Up"
    case quizRush = "Quiz Rush"

    var id: String { rawValue }

    var symbolName: String {
        switch self {
        case .tapFrenzy:
            return "hand.tap.fill"
        case .lightItUp:
            return "bolt.fill"
        case .quizRush:
            return "questionmark.circle.fill"
        }
    }
}