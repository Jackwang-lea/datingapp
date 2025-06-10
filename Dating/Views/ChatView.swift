import SwiftUI

struct ChatView: View {
    let match: Match
    @State private var messageText: String = ""
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        VStack {
            // 消息列表
            ScrollViewReader { proxy in
                ScrollView {
                    VStack(spacing: 15) {
                        // 匹配提示
                        HStack {
                            Spacer()
                            Text("你们匹配成功啦！开始聊天吧 👋")
                                .font(.subheadline)
                                .foregroundColor(.white)
                                .padding(10)
                                .background(Color.pink.opacity(0.8))
                                .cornerRadius(15)
                            Spacer()
                        }
                        .padding(.vertical, 10)
                        .id("top")
                        
                        // 这里可以添加更多消息
                        
                        // 底部占位，使消息从底部开始显示
                        Spacer()
                            .frame(height: 20)
                    }
                    .padding(.horizontal)
                }
                .onAppear {
                    // 滚动到底部
                    withAnimation {
                        proxy.scrollTo("top", anchor: .bottom)
                    }
                }
            }
            
            // 输入框
            HStack {
                // 图片选择按钮
                Button(action: {
                    // 选择图片
                }) {
                    Image(systemName: "photo")
                        .font(.system(size: 22))
                        .foregroundColor(.gray)
                        .padding(10)
                }
                
                // 文本输入框
                TextField("发送消息...", text: $messageText)
                    .padding(10)
                    .background(Color(.systemGray6))
                    .cornerRadius(20)
                    .padding(.vertical, 8)
                
                // 发送按钮
                Button(action: sendMessage) {
                    Image(systemName: "paperplane.fill")
                        .font(.system(size: 22))
                        .foregroundColor(.white)
                        .padding(10)
                        .background(messageText.isEmpty ? Color.gray : Color.pink)
                        .clipShape(Circle())
                }
                .disabled(messageText.isEmpty)
            }
            .padding(.horizontal)
            .padding(.bottom, 8)
            .background(Color(.systemBackground))
        }
        .navigationTitle("聊天")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func sendMessage() {
        guard !messageText.trimmingCharacters(in: .whitespaces).isEmpty else { return }
        
        // 发送消息
        appState.sendMessage(to: match.user2Id, message: messageText)
        
        // 清空输入框
        messageText = ""
    }
}

#Preview {
    NavigationView {
        ChatView(match: Match(
            id: "match_1",
            user1Id: "current_user_1",
            user2Id: "user_1",
            timestamp: Date(),
            lastMessage: "你好，很高兴认识你！",
            lastMessageTime: Date(),
            isRead: false
        ))
        .environmentObject(AppState())
    }
}
