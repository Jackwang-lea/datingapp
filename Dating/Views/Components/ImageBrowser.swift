import SwiftUI

struct ImageBrowser: View {
    @Binding var isPresented: Bool
    let imageNames: [String]
    @Binding var selectedIndex: Int
    @State private var scale: CGFloat = 1.0
    @State private var lastScale: CGFloat = 1.0
    @State private var offset: CGSize = .zero
    @State private var lastOffset: CGSize = .zero
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            // 半透明黑色背景
            Color.black.opacity(0.9)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    isPresented = false
                }
            
            // 图片浏览器
            TabView(selection: $selectedIndex) {
                ForEach(0..<imageNames.count, id: \.self) { index in
                    ZoomableImageView(imageName: imageNames[index], 
                                   scale: $scale, 
                                   lastScale: $lastScale, 
                                   offset: $offset, 
                                   lastOffset: $lastOffset)
                        .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            .onChange(of: selectedIndex) { oldValue, newValue in
                // 切换图片时重置缩放和偏移
                withAnimation(.spring()) {
                    scale = 1.0
                    lastScale = 1.0
                    offset = .zero
                    lastOffset = .zero
                }
            }
            
            // 关闭按钮
            Button(action: {
                isPresented = false
            }) {
                Image(systemName: "xmark.circle.fill")
                    .font(.system(size: 30))
                    .foregroundColor(.white)
                    .padding()
            }
        }
    }
}

struct ZoomableImageView: View {
    let imageName: String
    @Binding var scale: CGFloat
    @Binding var lastScale: CGFloat
    @Binding var offset: CGSize
    @Binding var lastOffset: CGSize
    
    var body: some View {
        GeometryReader { geometry in
            Image(imageName)
                .resizable()
                .scaledToFit()
                .scaleEffect(scale)
                .offset(offset)
                .gesture(
                    MagnificationGesture()
                        .onChanged { value in
                            let delta = value / lastScale
                            lastScale = value
                            let newScale = scale * delta
                            scale = min(max(newScale, 1.0), 5.0) // 限制缩放范围
                            
                            // 更新偏移量以保持图片居中
                            let bounds = geometry.size
                            let xOffset = (bounds.width * (scale - 1)) / 2
                            let yOffset = (bounds.height * (scale - 1)) / 2
                            offset = CGSize(width: xOffset, height: yOffset)
                        }
                        .onEnded { _ in
                            lastScale = 1.0
                        }
                )
                .simultaneousGesture(
                    DragGesture()
                        .onChanged { value in
                            if scale > 1.0 {
                                let delta = value.translation
                                let newOffset = CGSize(
                                    width: lastOffset.width + delta.width,
                                    height: lastOffset.height + delta.height
                                )
                                offset = newOffset
                            }
                        }
                        .onEnded { _ in
                            lastOffset = offset
                        }
                )
                .onTapGesture(count: 2) {
                    // 双击重置
                    withAnimation(.spring()) {
                        if scale > 1.0 {
                            scale = 1.0
                            offset = .zero
                            lastOffset = .zero
                        } else {
                            scale = 2.0
                            let bounds = geometry.size
                            let xOffset = (bounds.width * (2.0 - 1)) / 2
                            let yOffset = (bounds.height * (2.0 - 1)) / 2
                            offset = CGSize(width: xOffset, height: yOffset)
                            lastOffset = offset
                        }
                    }
                }
        }
    }
}

// MARK: - View Modifier
struct ImageBrowserModifier: ViewModifier {
    @Binding var isPresented: Bool
    let imageNames: [String]
    @Binding var selectedIndex: Int
    
    func body(content: Content) -> some View {
        content
            .fullScreenCover(isPresented: $isPresented) {
                ImageBrowser(isPresented: $isPresented, 
                           imageNames: imageNames, 
                           selectedIndex: $selectedIndex)
            }
    }
}

// MARK: - View Extension
extension View {
    func imageBrowser(isPresented: Binding<Bool>, 
                     imageNames: [String], 
                     selectedIndex: Binding<Int>) -> some View {
        self.modifier(ImageBrowserModifier(isPresented: isPresented, 
                                         imageNames: imageNames, 
                                         selectedIndex: selectedIndex))
    }
}

// MARK: - Preview
struct ImageBrowser_Previews: PreviewProvider {
    static var previews: some View {
        ImageBrowser(isPresented: .constant(true), 
                   imageNames: ["yoko-1", "yoko-2", "photo-placeholder"], 
                   selectedIndex: .constant(0))
    }
}