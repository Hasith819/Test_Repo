//
//  SettingsTabView.swift
//  ios-project
//
//  Created by student6 on 2026-07-06.
//

import SwiftUI

struct SettingsTabView: View {
    
    @State private var notificationsEnabled = false
    @State private var challengeTime = Date()
    
    @State private var showResetConfirmation = false
    @State private var showResetSuccess = false
    
    var body: some View {
        NavigationStack {
            Form {
                
                // MARK: - Daily Challenge
                Section {
                    Toggle(isOn: $notificationsEnabled.animation()) {
                        Label {
                            Text("Daily Challenge")
                        } icon: {
                            Image(systemName: "bell.badge.fill")
                                .foregroundStyle(.orange)
                        }
                    }
                    
                    if notificationsEnabled {
                        DatePicker(
                            "Reminder Time",
                            selection: $challengeTime,
                            displayedComponents: .hourAndMinute
                        )
                        .datePickerStyle(.compact)
                    }
                } header: {
                    Text("Notifications")
                } footer: {
                    Text(notificationsEnabled
                         ? "You'll get a reminder every day at the selected time to play your daily challenge."
                         : "Turn this on to get a daily reminder to come back and play.")
                }
                
                // MARK: - Data
                Section {
                    Button(role: .destructive) {
                        showResetConfirmation = true
                    } label: {
                        Label {
                            Text("Reset All Stats")
                                .foregroundStyle(.red)
                        } icon: {
                            Image(systemName: "trash.fill")
                                .foregroundStyle(.red)
                        }
                    }
                } header: {
                    Text("Data")
                } footer: {
                    Text("This permanently deletes your scores, high scores, and session history across all games.")
                }
                
                // MARK: - About
                Section {
                    HStack {
                        Label("Version", systemImage: "info.circle")
                        Spacer()
                        Text("1.0.0")
                            .foregroundStyle(.secondary)
                    }
                } header: {
                    Text("About")
                }
            }
            .navigationTitle("Settings")
            .confirmationDialog(
                "Reset all stats?",
                isPresented: $showResetConfirmation,
                titleVisibility: .visible
            ) {
                Button("Reset Everything", role: .destructive) {
                    showResetSuccess = true
                }
                Button("Cancel", role: .cancel) { }
            } message: {
                Text("This action cannot be undone. All scores and game history will be permanently deleted.")
            }
            .alert("Stats Reset", isPresented: $showResetSuccess) {
                Button("OK", role: .cancel) { }
            } message: {
                Text("All your stats have been cleared.")
            }
        }
    }
}

#Preview {
    SettingsTabView()
}