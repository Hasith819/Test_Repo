//
//  StatsTab.swift
//  ios-project
//
//  Created by student6 on 2026-07-06.
//

import SwiftUI
import Charts

struct StatsTabView: View {
    @State private var sessions: [GameSession] = GameSessionStore.shared.loadSessions()

    private var sortedSessions: [GameSession] {
        sessions.sorted { $0.timestamp > $1.timestamp }
    }

    private var totalSessions: Int {
        sessions.count
    }

    private var totalScore: Int {
        sessions.reduce(0) { $0 + $1.score }
    }

    private var bestSession: GameSession? {
        sessions.max(by: { $0.score < $1.score })
    }

    private var bestByMode: [(mode: GameMode, score: Int)] {
        GameMode.allCases.compactMap { mode in
            let bestScore = sessions.filter { $0.mode == mode }.map(\.
score).max()
            guard let bestScore else { return nil }
            return (mode: mode, score: bestScore)
        }
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                header
                summaryGrid
                chartSection
                bestScoresSection
                recentGamesSection
            }
            .padding()
        }
        .background(Color(.systemGroupedBackground))
        .onAppear {
            sessions = GameSessionStore.shared.loadSessions()
        }
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Game Stats")
                .font(.largeTitle)
                .fontWeight(.bold)

            Text("Track totals, bests, and recent sessions from every completed game.")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
    }

    private var summaryGrid: some View {
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
            statCard(title: "Sessions", value: "\(totalSessions)", subtitle: "Completed games")
            statCard(title: "Total Score", value: "\(totalScore)", subtitle: "Across all sessions")
            statCard(title: "Best Score", value: bestSession.map { "\($0.score)" } ?? "-", subtitle: bestSession.map { $0.mode.displayName } ?? "No games yet")
            statCard(title: "Modes", value: "\(GameMode.allCases.count)", subtitle: "Tracked game types")
        }
    }

    private var chartSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Score Chart")
                .font(.headline)

            if sessions.isEmpty {
                Text("Play a few games to see the chart.")
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity, minHeight: 180, alignment: .center)
                    .background(Color(.secondarySystemBackground), in: RoundedRectangle(cornerRadius: 16))
            } else {
                Chart(sortedSessions) { session in
                    BarMark(
                        x: .value("Session", session.timestamp),
                        y: .value("Score", session.score)
                    )
                    .foregroundStyle(by: .value("Mode", session.mode.displayName))
                }
                .frame(height: 240)
                .padding(.top, 4)
            }
        }
        .padding()
        .background(Color(.secondarySystemBackground), in: RoundedRectangle(cornerRadius: 18))
    }

    private var bestScoresSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Best Scores by Mode")
                .font(.headline)

            if bestByMode.isEmpty {
                Text("No scores yet.")
                    .foregroundStyle(.secondary)
            } else {
                ForEach(bestByMode, id: \.mode.id) { item in
                    HStack {
                        Text(item.mode.displayName)
                        Spacer()
                        Text("\(item.score)")
                            .fontWeight(.semibold)
                    }
                    .padding()
                    .background(Color(.tertiarySystemBackground), in: RoundedRectangle(cornerRadius: 14))
                }
            }
        }
        .padding()
        .background(Color(.secondarySystemBackground), in: RoundedRectangle(cornerRadius: 18))
    }

    private var recentGamesSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Recent Games")
                .font(.headline)

            if sortedSessions.isEmpty {
                Text("No completed games yet.")
                    .foregroundStyle(.secondary)
            } else {
                ForEach(Array(sortedSessions.prefix(8))) { session in
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(session.mode.displayName)
                                .font(.headline)
                            Text(session.timestamp, style: .date)
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }

                        Spacer()

                        Text("\(session.score)")
                            .font(.title3)
                            .fontWeight(.semibold)
                    }
                    .padding()
                    .background(Color(.tertiarySystemBackground), in: RoundedRectangle(cornerRadius: 14))
                }
            }
        }
        .padding()
        .background(Color(.secondarySystemBackground), in: RoundedRectangle(cornerRadius: 18))
    }

    private func statCard(title: String, value: String, subtitle: String) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.subheadline)
                .foregroundStyle(.secondary)

            Text(value)
                .font(.title)
                .fontWeight(.bold)

            Text(subtitle)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color(.secondarySystemBackground), in: RoundedRectangle(cornerRadius: 18))
    }
}

#Preview {
    StatsTabView()
}
