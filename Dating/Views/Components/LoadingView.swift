import SwiftUI

// 加载指示器视图
struct LoadingView: View {
    var message: String? = nil
    var showProgress: Bool = true
    
    var body: some View {
        VStack(spacing: 16) {
            if showProgress {
                ProgressView()
                    .scaleEffect(1.5)
                    .progressViewStyle(CircularProgressViewStyle(tint: .pink))
            }
            
            if let message = message, !message.isEmpty {
                Text(message)
                    .foregroundColor(.secondary)
                    .font(.subheadline)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemBackground))
    }
}

// 加载中覆盖层
struct LoadingOverlay: ViewModifier {
    var isShowing: Bool
    var message: String? = nil
    
    func body(content: Content) -> some View {
        ZStack {
            content
                .disabled(isShowing)
                .blur(radius: isShowing ? 2 : 0)
            
            if isShowing {
                LoadingView(message: message)
                    .opacity(0.9)
            }
        }
    }
}

// 加载更多视图
struct LoadMoreView: View {
    var isLoading: Bool
    var hasMore: Bool
    var onLoadMore: () -> Void
    
    var body: some View {
        Group {
            if isLoading {
                HStack {
                    Spacer()
                    ProgressView()
                        .padding()
                    Spacer()
                }
            } else if hasMore {
                Button(action: onLoadMore) {
                    Text("加载更多")
                        .foregroundColor(.pink)
                        .padding()
                }
            } else {
                Text("没有更多内容了")
                    .foregroundColor(.gray)
                    .font(.caption)
                    .padding()
            }
        }
    }
}

// 扩展 View 以方便使用加载视图
extension View {
    func loadingOverlay(isShowing: Bool, message: String? = nil) -> some View {
        self.modifier(LoadingOverlay(isShowing: isShowing, message: message))
    }
}

// 预览
struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            // 默认加载视图
            LoadingView()
                .previewDisplayName("默认加载")
            
            // 带消息的加载视图
            LoadingView(message: "正在加载数据...")
                .previewDisplayName("带消息的加载")
            
            // 加载更多视图
            VStack {
                Text("内容区域")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                LoadMoreView(
                    isLoading: true,
                    hasMore: true,
                    onLoadMore: {}
                )
            }
            .previewDisplayName("加载更多")
            
            // 加载覆盖层
            Text("内容")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .loadingOverlay(isShowing: true, message: "正在处理...")
                .previewDisplayName("加载覆盖层")
        }
    }
}
