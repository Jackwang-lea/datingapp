import Foundation

struct User: Identifiable, Codable {
    let id: String
    var name: String
    var age: Int
    var bio: String
    var photos: [String] // 图片URL或资源名称
    var interests: [String]
    var location: String
    var gender: Gender
    var preference: GenderPreference
    var lastActive: Date
    
    // 计算属性：显示年龄
    var ageString: String {
        return "\(age)岁"
    }
    
    // 计算属性：显示最后活跃时间
    var lastActiveString: String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        return formatter.localizedString(for: lastActive, relativeTo: Date())
    }
}

enum Gender: String, Codable, CaseIterable, Identifiable {
    case male = "男"
    case female = "女"
    case other = "其他"
    
    var id: String { self.rawValue }
}

enum GenderPreference: String, Codable, CaseIterable, Identifiable {
    case male = "男性"
    case female = "女性"
    case both = "不限"
    
    var id: String { self.rawValue }
}
