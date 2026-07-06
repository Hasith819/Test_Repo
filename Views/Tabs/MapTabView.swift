//
//  MapTab.swift
//  ios-project
//
//  Created by student6 on 2026-07-06.
//

import SwiftUI
import MapKit
import CoreLocation

struct MapTabView: View {
    @EnvironmentObject private var sessionStore: GameSessionStore
    @State private var selectedSessionID: GameSession.ID?

    private var selectedSession: GameSession? {
        sessionStore.sessions.first { $0.id == selectedSessionID }
    }

    private var sessionsWithLocation: [GameSession] {
        sessionStore.sessions
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            Map(initialPosition: .automatic) {
                ForEach(sessionsWithLocation) { session in
                    Annotation(session.mode.displayName, coordinate: session.coordinate) {
                        Button {
                            selectedSessionID = session.id
                        } label: {
                            VStack(spacing: 4) {
                                Image(systemName: session.mode.iconName)
                                    .font(.headline)
                                Text("\(session.score)")
                                    .font(.caption.bold())
                            }
                            .foregroundStyle(.white)
                            .padding(8)
                            .background(.blue, in: RoundedRectangle(cornerRadius: 14, style: .continuous))
                            .shadow(radius: 4)
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
            .mapControls {
                MapCompass()
                MapScaleView()
            }

            VStack(spacing: 12) {
                if sessionsWithLocation.isEmpty {
                    Text("Completed games will show up as pins here.")
                        .font(.headline)
                        .multilineTextAlignment(.center)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 20, style: .continuous))
                        .padding(.horizontal)
                        .padding(.bottom, 24)
                } else if let selectedSession {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(selectedSession.mode.displayName)
                            .font(.headline)
                        Text("Score: \(selectedSession.score)")
                        Text(selectedSession.timestamp.formatted(date: .abbreviated, time: .shortened))
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 20, style: .continuous))
                    .padding(.horizontal)
                    .padding(.bottom, 24)
                }
            }
        }
        .navigationTitle("Map")
        .onAppear {
            if selectedSessionID == nil {
                selectedSessionID = sessionsWithLocation.first?.id
            }
        }
        .onChange(of: sessionStore.sessions) { _ in
            if selectedSessionID == nil || !sessionsWithLocation.contains(where: { $0.id == selectedSessionID }) {
                selectedSessionID = sessionsWithLocation.first?.id
            }
        }
    }
}

#Preview {
    MapTabView()
        .environmentObject(GameSessionStore())
}
