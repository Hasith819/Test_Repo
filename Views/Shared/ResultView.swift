//
//  ResultView.swift
//  ios-project
//
//  Created by student6 on 2026-07-05.
//

import SwiftUI

struct ResultView: View {
    let title: String
    let score: Int
    let shareText: String

    var body: some View {
        VStack(spacing: 16) {
            Text(title)
                .font(.largeTitle.bold())

            Text("\(score)")
                .font(.system(size: 56, weight: .bold))

            ShareLink(item: shareText) {
                Label("Share Score", systemImage: "square.and.arrow.up")
                    .fontWeight(.semibold)
            }
            .buttonStyle(.borderedProminent)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
    }
}