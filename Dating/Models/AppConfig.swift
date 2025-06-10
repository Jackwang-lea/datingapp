import SwiftUI

// 应用配置
struct AppConfig {
    // API 基础 URL
    static let apiBaseURL = "https://api.datingapp.com/v1"
    
    // 分页大小
    static let pageSize = 20
    
    // 应用主题色
    static let primaryColor = Color.pink
    static let secondaryColor = Color.blue
    static let backgroundColor = Color(.systemGray6)
    
    // 圆角半径
    static let cornerRadius: CGFloat = 12
    static let smallCornerRadius: CGFloat = 8
    
    // 动画时长
    static let animationDuration: Double = 0.3
    
    // 阴影
    static let shadowColor = Color.black.opacity(0.1)
    static let shadowRadius: CGFloat = 10
    static let shadowOffset: CGFloat = 4
    
    // 字体大小
    struct FontSize {
        static let largeTitle: CGFloat = 32
        static let title: CGFloat = 24
        static let title2: CGFloat = 20
        static let headline: CGFloat = 18
        static let body: CGFloat = 16
        static let subheadline: CGFloat = 14
        static let caption: CGFloat = 12
    }
    
    // 间距
    struct Spacing {
        static let small: CGFloat = 8
        static let medium: CGFloat = 16
        static let large: CGFloat = 24
        static let extraLarge: CGFloat = 32
    }
    
    // 图片尺寸
    struct ImageSize {
        static let small: CGFloat = 24
        static let medium: CGFloat = 40
        static let large: CGFloat = 60
        static let extraLarge: CGFloat = 100
    }
    
    // 默认占位图
    static let placeholderImage = "person.circle.fill"
    
    // 默认头像
    static let defaultAvatar = "person.crop.circle"
    
    // 默认用户信息
    static let defaultUserBio = "这个人很懒，什么也没留下~"
    
    // 应用名称
    static let appName = "心动"
    
    // 应用版本
    static var appVersion: String {
        Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0.0"
    }
    
    // 构建版本号
    static var buildNumber: String {
        Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "1"
    }
    
    // 设备信息
    static var deviceModel: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        return identifier
    }
    
    // 系统版本
    static var systemVersion: String {
        UIDevice.current.systemVersion
    }
    
    // 设备名称
    static var deviceName: String {
        UIDevice.current.name
    }
    
    // 屏幕尺寸
    static var screenSize: CGSize {
        UIScreen.main.bounds.size
    }
    
    // 是否是小屏幕设备
    static var isSmallScreen: Bool {
        screenSize.width <= 375
    }
}
