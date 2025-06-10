import SwiftUI

// 主要按钮样式
struct PrimaryButton: ViewModifier {
    var isEnabled: Bool = true
    var isFullWidth: Bool = true
    
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .foregroundColor(.white)
            .frame(maxWidth: isFullWidth ? .infinity : nil)
            .padding()
            .background(isEnabled ? Color.pink : Color.gray)
            .cornerRadius(10)
            .opacity(isEnabled ? 1 : 0.6)
    }
}

// 次要按钮样式
struct SecondaryButton: ViewModifier {
    var isFullWidth: Bool = true
    
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .foregroundColor(.pink)
            .frame(maxWidth: isFullWidth ? .infinity : nil)
            .padding()
            .background(Color.pink.opacity(0.1))
            .cornerRadius(10)
    }
}

// 文本按钮样式
struct TextButton: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.subheadline)
            .foregroundColor(.pink)
    }
}

// 图标按钮样式
struct IconButton: ViewModifier {
    var size: CGFloat = 44
    
    func body(content: Content) -> some View {
        content
            .frame(width: size, height: size)
            .background(Color(.systemGray6))
            .clipShape(Circle())
            .foregroundColor(.primary)
    }
}

// 扩展 View 以方便使用这些样式
extension View {
    func primaryButton(isEnabled: Bool = true, isFullWidth: Bool = true) -> some View {
        self.modifier(PrimaryButton(isEnabled: isEnabled, isFullWidth: isFullWidth))
    }
    
    func secondaryButton(isFullWidth: Bool = true) -> some View {
        self.modifier(SecondaryButton(isFullWidth: isFullWidth))
    }
    
    func textButton() -> some View {
        self.modifier(TextButton())
    }
    
    func iconButton(size: CGFloat = 44) -> some View {
        self.modifier(IconButton(size: size))
    }
}

// 预览
struct Buttons_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 20) {
            Text("主要按钮")
                .primaryButton()
            
            Text("禁用按钮")
                .primaryButton(isEnabled: false)
            
            Text("次要按钮")
                .secondaryButton()
            
            Text("文本按钮")
                .textButton()
            
            HStack {
                Image(systemName: "heart")
                    .iconButton()
                
                Image(systemName: "message")
                    .iconButton(size: 50)
            }
        }
        .padding()
    }
}
