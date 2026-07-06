//
//  GameMode.swift
//  ios-project
//
//  Created by Copilot on 2026-07-06.
//

import Foundation

enum GameMode: String, CaseIterable, Codable, Identifiable {
    case tapFrenzy
    case lightItUp
    case quizRush

    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .tapFrenzy:
            return "Tap Frenzy"
        case .lightItUp:
            return "Light It Up"
        case .quizRush:
            return "Quiz Rush"
        }
    }

    var iconName: String {
        switch self {
        case .tapFrenzy:
            return "hand.tap.fill"
        case .lightItUp:
            return "sparkles"
        case .quizRush:
            return "questionmark.circle.fill"
        }
    }
}