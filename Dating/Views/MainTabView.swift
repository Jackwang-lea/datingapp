import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        TabView(selection: $appState.selectedTab) {
            DiscoverView()
                .tabItem {
                    VStack {
                        Image(systemName: "person.2.fill")
                            .imageScale(.large)
                        Text("推荐")
                            .font(.caption)
                    }
                }
                .tag(0)
            
            MatchesView()
                .tabItem {
                    VStack {
                        Image(systemName: "heart.fill")
                            .imageScale(.large)
                        Text("匹配")
                            .font(.caption)
                    }
                }
                .tag(1)
            
            MessagesView()
                .tabItem {
                    VStack {
                        Image(systemName: "message.fill")
                            .imageScale(.large)
                        Text("消息")
                            .font(.caption)
                    }
                }
                .tag(2)
            
            ProfileView()
                .tabItem {
                    VStack {
                        Image(systemName: "person.fill")
                            .imageScale(.large)
                        Text("我的")
                            .font(.caption)
                    }
                }
                .tag(3)
        }
        .accentColor(.pink)
        .tint(.pink)
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
            .environmentObject(AppState())
    }
}
