//
//  ios_projectApp.swift
//  ios-project
//
//  Created by student6 on 2026-06-06.
//

import SwiftUI

@main
struct PlayHubApp: App {
    @StateObject private var sessionStore = GameSessionStore()
    @StateObject private var locationService = LocationService()

    var body: some Scene {
        WindowGroup {
            AppTabShellView()
                .environmentObject(sessionStore)
                .environmentObject(locationService)
        }
    }
}
