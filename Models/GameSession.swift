//
//  GameSession.swift
//  ios-project
//
//  Created by student6 on 2026-07-05.
//

import Foundation

struct GameSession: Identifiable, Codable {
    let id: UUID
    let mode: GameMode
    let score: Int
    let timestamp: Date
    let latitude: Double
    let longitude: Double
}