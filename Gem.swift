//
//  StatsTab.swift
//  ios-project
//
//  Created by student6 on 2026-07-06.
//

import SwiftUI

struct StatsTabView: View {
    @State private var sessions: [GameSession] = GameSessionStore.shared.loadSessions()

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Game Stats")
                .font(.largeTitle)
                .fontWeight(.bold)

            Text("Completed sessions: \(sessions.count)")
                .font(.title3)
                .foregroundStyle(.cyan)

            if let latest = sessions.sorted(by: { $0.timestamp > $1.timestamp }).first {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Latest session")
                        .font(.headline)

                    Text("\(latest.mode.displayName) - Score \(latest.score)")
                    Text(latest.timestamp, style: .date)
                        .foregroundStyle(.secondary)
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 16))
            }

            ScrollView {
                LazyVStack(spacing: 12) {
                    ForEach(sessions.sorted(by: { $0.timestamp > $1.timestamp })) { session in
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
                        .frame(maxWidth: .infinity)
                        .background(Color(.secondarySystemBackground), in: RoundedRectangle(cornerRadius: 14))
            }
                }
            }

            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(Color.white)
        .onAppear {
            sessions = GameSessionStore.shared.loadSessions()
        }
    }
}

#Preview {
    StatsTabView()
}
