//
//  GameSessionStore.swift
//  ios-project
//
//  Created by Copilot on 2026-07-06.
//

import Foundation
import CoreLocation

@MainActor
final class GameSessionStore: ObservableObject {
    @Published private(set) var sessions: [GameSession] = []

    private let storageKey = "PlayHubGameSessions"

    init() {
        load()
    }

    func recordSession(mode: GameMode, score: Int, coordinate: CLLocationCoordinate2D?) {
        let resolvedCoordinate = coordinate ?? CLLocationCoordinate2D(latitude: 0, longitude: 0)

        let session = GameSession(
            id: UUID(),
            mode: mode,
            score: score,
            timestamp: .now,
            latitude: resolvedCoordinate.latitude,
            longitude: resolvedCoordinate.longitude
        )

        sessions.insert(session, at: 0)
        save()
    }

    func resetAll() {
        sessions.removeAll()
        save()
    }

    private func load() {
        guard let data = UserDefaults.standard.data(forKey: storageKey) else {
            sessions = []
            return
        }

        do {
            sessions = try JSONDecoder().decode([GameSession].self, from: data)
        } catch {
            sessions = []
        }
    }

    private func save() {
        do {
            let data = try JSONEncoder().encode(sessions)
            UserDefaults.standard.set(data, forKey: storageKey)
        } catch {
            print("Failed to save game sessions: \(error)")
        }
    }
}