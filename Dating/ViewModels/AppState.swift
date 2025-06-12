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
        
        // 模拟数据 - 实际应用中应从网络或本地数据库加载
        loadMockData()
    }
    
    private func checkLoginStatus() {
        // 从 UserDefaults 检查登录状态
        isLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")
        showLogin = !isLoggedIn
    }
    
    func logout() {
        // 清除登录状态
        isLoggedIn = false
        showLogin = true
        UserDefaults.standard.set(false, forKey: "isLoggedIn")
        UserDefaults.standard.removeObject(forKey: "userId")
        // 可以在这里添加其他清理逻辑，如清除用户数据等
    }
    
    private func loadMockData() {
        // 模拟当前用户
        currentUser = User(
            id: "current_user_1",
            name: "张明",
            age: 28,
            bio: "热爱生活，喜欢旅行和美食，寻找志同道合的伴侣",
            photos: ["profile_1", "profile_2"],
            interests: ["旅行", "美食", "摄影", "电影", "音乐"],
            location: "北京市朝阳区",
            gender: .male,
            preference: .female,
            lastActive: Date()
        )
        
        // 模拟其他用户
        users = [
            User(
                id: "user_1",
                name: "李婷",
                age: 25,
                bio: "喜欢阅读和旅行，希望找到一个有趣的灵魂",
                photos: ["user1_1", "user1_2"],
                interests: ["阅读", "旅行", "咖啡", "摄影"],
                location: "北京市海淀区",
                gender: .female,
                preference: .male,
                lastActive: Date().addingTimeInterval(-3600)
            ),
            User(
                id: "user_2",
                name: "王芳",
                age: 27,
                bio: "程序员小姐姐，喜欢打游戏和看动漫",
                photos: ["user2_1", "user2_2"],
                interests: ["编程", "游戏", "动漫", "美食"],
                location: "北京市朝阳区",
                gender: .female,
                preference: .male,
                lastActive: Date().addingTimeInterval(-7200)
            )
        ]
        
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
}
