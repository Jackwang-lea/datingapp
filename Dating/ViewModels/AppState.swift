import SwiftUI
import Combine

class AppState: ObservableObject {
    // 当前登录用户
    @Published var currentUser: User?
    
    // 用户列表（用于发现页）
    @Published var users: [User] = []
    
    // 匹配列表
    @Published var matches: [Match] = []
    
    // 是否显示登录界面
    @Published var showLogin: Bool = false
    
    // 是否已登录
    @Published var isLoggedIn: Bool = false
    
    // 是否显示加载指示器
    @Published var isLoading: Bool = false
    
    // 选中的标签页
    @Published var selectedTab: Tab = .discover
    
    // 应用标签页
    enum Tab: Int {
        case discover, matches, messages, profile
    }
    
    init() {
        // 检查本地存储的登录状态
        checkLoginStatus()
        
        // 只有在未登录或没有当前用户数据时才加载模拟数据
        if !isLoggedIn || currentUser == nil {
            loadMockData()
        }
    }
    
    private func checkLoginStatus() {
        // 从 UserDefaults 检查登录状态
        isLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")
        showLogin = !isLoggedIn
        
        print("检查登录状态: \(isLoggedIn ? "已登录" : "未登录")")
    }
    
    func logout() {
        // 清除登录状态
        isLoggedIn = false
        showLogin = true
        UserDefaults.standard.set(false, forKey: "isLoggedIn")
        UserDefaults.standard.removeObject(forKey: "userId")
        // 可以在这里添加其他清理逻辑，如清除用户数据等
    }
    
    func loadMockData() {
        // 模拟用户列表，包含我们为预览创建的 mock 用户
        self.users = [User.mock, 
                      User(id: "user_2", name: "李婷", age: 25, bio: "喜欢阅读和旅行", imageNames: ["photo-placeholder"], interests: ["阅读", "旅行"], location: "北京", gender: .female, preference: .male, education: .master, lastActive: Date().addingTimeInterval(-3600)),
                      User(id: "user_3", name: "王芳", age: 27, bio: "程序员小姐姐", imageNames: ["photo-placeholder"], interests: ["编程", "游戏"], location: "上海", gender: .female, preference: .male, education: .bachelor, lastActive: Date().addingTimeInterval(-7200))
        ]
        
        // 模拟当前登录的用户
        self.currentUser = users.first
        // 模拟匹配
        matches = [
            Match(
                id: "match_1",
                user1Id: "current_user_1",
                user2Id: "user_1",
                timestamp: Date().addingTimeInterval(-86400),
                lastMessage: "你好，很高兴认识你！",
                lastMessageTime: Date().addingTimeInterval(-3600),
                isRead: false
            )
        ]
    }
    
    // 喜欢用户
    func likeUser(_ user: User) {
        // 在实际应用中，这里会调用API
        print("喜欢用户: \(user.name)")
    }
    
    // 不喜欢用户
    func dislikeUser(_ user: User) {
        // 在实际应用中，这里会调用API
        print("不喜欢用户: \(user.name)")
    }
    
    // 发送消息
    func sendMessage(to userId: String, message: String) {
        // 在实际应用中，这里会调用API
        print("发送消息给 \(userId): \(message)")
    }
    
    // 用于 SwiftUI 预览的 mock 实例
    static var mock: AppState {
        let appState = AppState()
        appState.users = [User.mock, 
                         User(id: "user_2", name: "李婷", age: 25, bio: "喜欢阅读和旅行", imageNames: ["photo-placeholder"], interests: ["阅读", "旅行"], location: "北京", gender: .female, preference: .male, education: .master, lastActive: Date().addingTimeInterval(-3600)),
                         User(id: "user_3", name: "王芳", age: 27, bio: "程序员小姐姐", imageNames: ["photo-placeholder"], interests: ["编程", "游戏"], location: "上海", gender: .female, preference: .male, education: .bachelor, lastActive: Date().addingTimeInterval(-7200))
        ]
        appState.currentUser = appState.users.first
        return appState
    }
}
