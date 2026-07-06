//
//  SettingsTabView.swift
//  ios-project
//
//  Created by student6 on 2026-07-05.
//

import SwiftUI

struct SettingsTabView: View {
    @State private var notificationsEnabled = true
    @State private var dailyChallengeTime = Date()
    @State private var showResetConfirmation = false

    var body: some View {
        Form {
            Section("Daily Challenge") {
                Toggle("Notifications", isOn: $notificationsEnabled)
                DatePicker("Time", selection: $dailyChallengeTime, displayedComponents: .hourAndMinute)
            }

            Section {
                Button("Reset All Stats", role: .destructive) {
                    showResetConfirmation = true
                }
            }
        }
        .navigationTitle("Settings")
        .confirmationDialog("Reset all stats?", isPresented: $showResetConfirmation, titleVisibility: .visible) {
            Button("Reset", role: .destructive) {
            }
        }
    }
}