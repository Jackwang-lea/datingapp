import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        TabView(selection: $appState.selectedTab) {
            DiscoverView()
                .tabItem {
                    Label("发现", systemImage: "person.2.fill")
                }
                .tag(0)
            
            MatchesView()
                .tabItem {
                    Label("匹配", systemImage: "heart.fill")
                }
                .tag(1)
            
            MessagesView()
                .tabItem {
                    Label("消息", systemImage: "message.fill")
                }
                .tag(2)
            
            ProfileView()
                .tabItem {
                    Label("我的", systemImage: "person.fill")
                }
                .tag(3)
        }
        .accentColor(.pink)
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
            .environmentObject(AppState())
    }
}
