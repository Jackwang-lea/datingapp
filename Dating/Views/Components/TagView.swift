import SwiftUI

// 标签视图
struct TagView: View {
    let title: String
    var isSelected: Bool = false
    var isEditable: Bool = false
    var onDelete: (() -> Void)? = nil
    
    var body: some View {
        HStack(spacing: 4) {
            Text(title)
                .font(.caption)
                .lineLimit(1)
            
            if isEditable && onDelete != nil {
                Button(action: {
                    onDelete?()
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 6)
        .background(isSelected ? Color.pink.opacity(0.2) : Color(.systemGray6))
        .foregroundColor(isSelected ? .pink : .primary)
        .cornerRadius(15)
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(isSelected ? Color.pink : Color.clear, lineWidth: 1)
        )
    }
}

// 标签选择器
struct TagsView: View {
    @Binding var selectedTags: [String]
    let allTags: [String]
    var maxSelectable: Int? = nil
    var isEditable: Bool = false
    var onTagTapped: ((String) -> Void)? = nil
    
    private let columns = [
        GridItem(.flexible(), spacing: 8),
        GridItem(.flexible(), spacing: 8),
        GridItem(.flexible(), spacing: 8)
    ]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 12) {
            ForEach(allTags, id: \.self) { tag in
                let isSelected = selectedTags.contains(tag)
                
                TagView(
                    title: tag,
                    isSelected: isSelected,
                    isEditable: isEditable && isSelected
                ) {
                    if let index = selectedTags.firstIndex(of: tag) {
                        selectedTags.remove(at: index)
                    }
                }
                .onTapGesture {
                    if let onTap = onTagTapped {
                        onTap(tag)
                    } else {
                        toggleTag(tag)
                    }
                }
                .opacity(isSelectable(tag) ? 1 : 0.5)
            }
        }
    }
    
    private func toggleTag(_ tag: String) {
        if let index = selectedTags.firstIndex(of: tag) {
            selectedTags.remove(at: index)
        } else if isSelectable(tag) {
            selectedTags.append(tag)
        }
    }
    
    private func isSelectable(_ tag: String) -> Bool {
        if let max = maxSelectable, selectedTags.count >= max, !selectedTags.contains(tag) {
            return false
        }
        return true
    }
}

// 可滚动的标签云
struct TagCloudView: View {
    let tags: [String]
    @Binding var selectedTags: [String]
    var maxSelectable: Int? = nil
    var spacing: CGFloat = 8
    var alignment: HorizontalAlignment = .leading
    var tagAction: ((String) -> Void)? = nil
    
    var body: some View {
        var width = CGFloat.zero
        var totalHeight = CGFloat.zero
        
        return GeometryReader { geometry in
            ZStack(alignment: .topLeading) {
                ForEach(tags, id: \.self) { tag in
                    let isSelected = selectedTags.contains(tag)
                    
                    TagView(title: tag, isSelected: isSelected)
                        .padding(.trailing, spacing)
                        .padding(.bottom, spacing)
                        .onTapGesture {
                            if let action = tagAction {
                                action(tag)
                            } else {
                                toggleTag(tag)
                            }
                        }
                        .alignmentGuide(.leading) { dimension in
                            if abs(width - dimension.width) > geometry.size.width {
                                width = 0
                                totalHeight -= dimension.height
                            }
                            let result = width
                            if tag == tags.last {
                                width = 0
                            } else {
                                width -= dimension.width + spacing
                            }
                            return result
                        }
                        .alignmentGuide(.top) { dimension in
                            let result = totalHeight
                            if tag == tags.last {
                                totalHeight = 0
                            }
                            return result
                        }
                }
            }
        }
    }
    
    private func toggleTag(_ tag: String) {
        if let index = selectedTags.firstIndex(of: tag) {
            selectedTags.remove(at: index)
        } else if isSelectable(tag) {
            selectedTags.append(tag)
        }
    }
    
    private func isSelectable(_ tag: String) -> Bool {
        if let max = maxSelectable, selectedTags.count >= max, !selectedTags.contains(tag) {
            return false
        }
        return true
    }
}

// 预览
struct TagView_Previews: PreviewProvider {
    static let interests = [
        "旅行", "美食", "摄影", "电影", "音乐", "阅读", "运动", "游戏",
        "编程", "设计", "艺术", "写作", "咖啡", "茶道", "健身", "瑜伽"
    ]
    
    @State static var selectedTags: [String] = ["旅行", "美食"]
    
    static var previews: some View {
        VStack(spacing: 20) {
            // 单个标签
            HStack {
                TagView(title: "旅行")
                TagView(title: "美食", isSelected: true)
                TagView(title: "摄影", isEditable: true) {}
            }
            .padding()
            .previewDisplayName("单个标签")
            
            Divider()
            
            // 标签网格
            ScrollView {
                TagsView(
                    selectedTags: $selectedTags,
                    allTags: interests,
                    maxSelectable: 5
                )
                .padding()
            }
            .frame(height: 300)
            .previewDisplayName("标签网格")
            
            Divider()
            
            // 标签云
            ScrollView {
                TagCloudView(
                    tags: interests,
                    selectedTags: $selectedTags,
                    maxSelectable: 3
                )
                .padding()
            }
            .frame(height: 300)
            .previewDisplayName("标签云")
        }
    }
}
