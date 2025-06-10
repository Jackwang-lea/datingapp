import SwiftUI

struct MatchesView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(.systemGray6)
                    .edgesIgnoringSafeArea(.all)
                
                if appState.matches.isEmpty {
                    VStack(spacing: 20) {
                        Image(systemName: "heart.text.square")
                            .font(.system(size: 70))
                            .foregroundColor(.gray)
                        Text("暂无匹配")
                            .font(.title2)
                            .fontWeight(.medium)
                        Text("当你和其他人互相喜欢时，就会出现在这里")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 40)
                    }
                    .offset(y: -50)
                } else {
                    List {
                        ForEach(appState.matches) { match in
                            NavigationLink(destination: ChatView(match: match)) {
                                MatchRow(match: match)
                            }
                        }
                    }
                    .listStyle(PlainListStyle())
                }
            }
            .navigationTitle("匹配")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct MatchRow: View {
    let match: Match
    @State private var lastMessage: String = ""
    
    var body: some View {
        HStack(spacing: 15) {
            // 用户头像
            Circle()
                .fill(Color.gray.opacity(0.3))
                .frame(width: 60, height: 60)
                .overlay(
                    Image(systemName: "person.fill")
                        .font(.title)
                        .foregroundColor(.gray)
                )
            
            VStack(alignment: .leading, spacing: 5) {
                // 用户名
                Text("用户 \(match.user2Id.prefix(5))...")
                    .font(.headline)
                
                // 最后一条消息
                if let message = match.lastMessage {
                    Text(message)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .lineLimit(1)
                }
            }
            
            Spacer()
            
            // 最后活跃时间
            Text(match.lastMessageTimeString)
                .font(.caption2)
                .foregroundColor(.gray)
                .frame(width: 50, alignment: .trailing)
            
            // 未读消息标记
            if !match.isRead {
                Circle()
                    .fill(Color.pink)
                    .frame(width: 10, height: 10)
            }
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    MatchesView()
        .environmentObject(AppState())
}
