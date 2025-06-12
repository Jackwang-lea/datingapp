//
//  DatingApp.swift
//  Dating
//
//  Created by zhetaoWang on 2025/6/10.
//

import SwiftUI

@main
struct DatingApp: App {
    @StateObject private var appState = AppState()
    
    var body: some Scene {
        WindowGroup {
            Group {
                if !appState.isLoggedIn {
                    LoginView()
                        .environmentObject(appState)
                        .transition(.opacity)
                } else if appState.currentUser != nil {
                    MainTabView()
                        .environmentObject(appState)
                        .transition(.opacity)
                } else {
                    ProgressView("加载中...")
                }
            }
            .animation(.easeInOut, value: appState.isLoggedIn)
        }
    }
}
