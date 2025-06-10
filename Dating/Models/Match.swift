import Foundation

struct Match: Identifiable, Codable {
    let id: String
    let user1Id: String
    let user2Id: String
    let timestamp: Date
    var lastMessage: String?
    var lastMessageTime: Date?
    var isRead: Bool
    
    // 计算属性：显示最后消息时间
    var lastMessageTimeString: String {
        guard let time = lastMessageTime else { return "" }
        let formatter = DateFormatter()
        
        if Calendar.current.isDateInToday(time) {
            formatter.dateFormat = "HH:mm"
            return formatter.string(from: time)
        } else if Calendar.current.isDateInYesterday(time) {
            return "昨天"
        } else {
            formatter.dateFormat = "MM/dd"
            return formatter.string(from: time)
        }
    }
}
