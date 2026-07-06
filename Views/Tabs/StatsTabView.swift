//
//  StatsTabView.swift
//  ios-project
//
//  Created by student6 on 2026-07-05.
//

import SwiftUI

struct StatsTabView: View {
    @AppStorage("TapFrenzyHighScore") private var tapFrenzyHighScore = 0
    @AppStorage("LightItUpHighScore") private var lightItUpHighScore = 0
    @AppStorage("QuizRushHighScore") private var quizRushHighScore = 0

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("Stats")
                    .font(.largeTitle.bold())

                Text("High-score summary lives here for now. Session history and charts come next.")
                    .foregroundStyle(.secondary)

                VStack(spacing: 12) {
                    ScoreBadge(title: "Tap Frenzy", value: tapFrenzyHighScore.description)
                    ScoreBadge(title: "Light It Up", value: lightItUpHighScore.description)
                    ScoreBadge(title: "Quiz Rush", value: quizRushHighScore.description)
                }
            }
            .padding()
        }
        .navigationTitle("Stats")
    }
}