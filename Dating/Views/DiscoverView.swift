import SwiftUI

struct DiscoverView: View {
    @EnvironmentObject var appState: AppState
    @State private var currentIndex = 0
    @State private var offset: CGSize = .zero
    
    var body: some View {
        NavigationView {
            ZStack {
                // 背景色
                Color(.systemGray6)
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 0) {
                    // 顶部标题
                    HStack {
                        Text("发现")
                            .font(.system(size: 32, weight: .bold))
                            .padding(.horizontal)
                        Spacer()
                        
                        Button(action: {
                            // 筛选功能
                        }) {
                            Image(systemName: "slider.horizontal.3")
                                .font(.title2)
                                .foregroundColor(.primary)
                        }
                        .padding(.trailing)
                    }
                    .padding(.top, 10)
                    
                    // 用户卡片堆叠
                    if !appState.users.isEmpty {
                        ZStack {
                            ForEach(0..<min(3, appState.users.count), id: \.self) { index in
                                let user = appState.users[(currentIndex + index) % appState.users.count]
                                UserCardView(user: user)
                                    .rotationEffect(.degrees(Double(offset.width / 20)))
                                    .offset(x: index == 0 ? offset.width : 0, y: index == 0 ? offset.height : 0)
                                    .scaleEffect(index == 0 ? 1 : 1 - CGFloat(index) * 0.1)
                                    .opacity(index == 0 ? 1 : 0.8)
                                    .zIndex(Double(-index))
                                    .gesture(
                                        index == 0 ?
                                        DragGesture()
                                            .onChanged { value in
                                                self.offset = value.translation
                                            }
                                            .onEnded { value in
                                                withAnimation {
                                                    if abs(value.translation.width) > 100 {
                                                        if value.translation.width > 0 {
                                                            // 右滑喜欢
                                                            appState.likeUser(user)
                                                        } else {
                                                            // 左滑不喜欢
                                                            appState.dislikeUser(user)
                                                        }
                                                        currentIndex = (currentIndex + 1) % appState.users.count
                                                    }
                                                    self.offset = .zero
                                                }
                                            } : nil
                                    )
                            }
                        }
                        .frame(height: 500)
                        .padding()
                    } else {
                        // 没有更多用户时的提示
                        VStack(spacing: 20) {
                            Image(systemName: "person.2.slash")
                                .font(.system(size: 60))
                                .foregroundColor(.gray)
                            Text("暂时没有更多推荐了")
                                .font(.title2)
                                .foregroundColor(.gray)
                            Text("稍后再来看看吧")
                                .foregroundColor(.gray)
                        }
                        .frame(maxHeight: .infinity)
                    }
                    
                    // 底部操作按钮
                    HStack(spacing: 40) {
                        Button(action: {
                            // 不喜欢
                            withAnimation {
                                if !appState.users.isEmpty {
                                    let user = appState.users[currentIndex % appState.users.count]
                                    appState.dislikeUser(user)
                                    currentIndex = (currentIndex + 1) % appState.users.count
                                }
                            }
                        }) {
                            Image(systemName: "xmark")
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(.white)
                                .padding(20)
                                .background(Color.red)
                                .clipShape(Circle())
                                .shadow(radius: 5)
                        }
                        
                        Button(action: {
                            // 超级喜欢
                        }) {
                            Image(systemName: "star.fill")
                                .font(.system(size: 24))
                                .foregroundColor(.white)
                                .padding(20)
                                .background(Color.blue)
                                .clipShape(Circle())
                                .shadow(radius: 5)
                        }
                        
                        Button(action: {
                            // 喜欢
                            withAnimation {
                                if !appState.users.isEmpty {
                                    let user = appState.users[currentIndex % appState.users.count]
                                    appState.likeUser(user)
                                    currentIndex = (currentIndex + 1) % appState.users.count
                                }
                            }
                        }) {
                            Image(systemName: "heart.fill")
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(.white)
                                .padding(20)
                                .background(Color.green)
                                .clipShape(Circle())
                                .shadow(radius: 5)
                        }
                    }
                    .padding(.bottom, 30)
                }
            }
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    DiscoverView()
        .environmentObject(AppState())
}
