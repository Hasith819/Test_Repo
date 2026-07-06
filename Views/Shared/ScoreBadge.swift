//
//  ScoreBadge.swift
//  ios-project
//
//  Created by student6 on 2026-07-05.
//

import SwiftUI

struct ScoreBadge: View {
    let title: String
    let value: String

    var body: some View {
        HStack {
            Text(title)
                .fontWeight(.semibold)
            Spacer()
            Text(value)
                .font(.title3.bold())
        }
        .padding()
        .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 18, style: .continuous))
    }
}