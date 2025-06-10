//
//  ContentView.swift
//  Dating
//
//  Created by zhetaoWang on 2025/6/10.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        ZStack {
            // 主内容
            if appState.currentUser != nil {
                MainTabView()
                    .environmentObject(appState)
                    .transition(.opacity)
            } else {
                LoginView()
                    .environmentObject(appState)
                    .transition(.opacity)
            }
            
            // 全局加载指示器
            if appState.isLoading {
                Color.black.opacity(0.3)
                    .edgesIgnoringSafeArea(.all)
                    .overlay(
                        ProgressView()
                            .scaleEffect(1.5)
                    )
            }
        }
        .animation(.easeInOut, value: appState.currentUser != nil)
        .onAppear {
            // 检查用户登录状态
            checkAuthStatus()
        }
    }
    
    private func checkAuthStatus() {
        // 模拟检查登录状态
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            // 这里应该调用API检查登录状态
            // 如果已登录，设置 appState.currentUser
            // 如果未登录，设置 appState.currentUser = nil
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(AppState())
}
