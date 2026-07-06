//
//  MapTabView.swift
//  ios-project
//
//  Created by student6 on 2026-07-05.
//

import SwiftUI

struct MapTabView: View {
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "map.fill")
                .font(.system(size: 48))
                .foregroundStyle(.blue)

            Text("Map")
                .font(.largeTitle.bold())

            Text("Completed sessions will appear as pins on the map.")
                .multilineTextAlignment(.center)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
        .navigationTitle("Map")
    }
}