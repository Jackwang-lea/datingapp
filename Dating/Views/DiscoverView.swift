import SwiftUI

struct DiscoverView: View {
    @EnvironmentObject var appState: AppState
    @State private var currentIndex = 0
    @State private var offset: CGSize = .zero
    @State private var selectedEducation: Education? = nil
    @State private var showFilter = false
    
    // 计算属性：获取筛选后的用户列表
    private var filteredUsers: [User] {
        if let education = selectedEducation {
            return appState.users.filter { $0.education == education }
        } else {
            return appState.users
        }
    }
    
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
                            showFilter = true
                        }) {
                            Image(systemName: "slider.horizontal.3")
                                .font(.title2)
                                .foregroundColor(selectedEducation != nil ? .pink : .primary)
                        }
                        .padding(.trailing)
                    }
                    .padding(.top, 10)
                    .sheet(isPresented: $showFilter) {
                        FilterView(selectedEducation: $selectedEducation)
                    }
                    
                    // 用户卡片堆叠
                    if !appState.users.isEmpty {
                        ZStack {
                            ForEach(0..<min(3, filteredUsers.count), id: \.self) { index in
                                let user = filteredUsers[(currentIndex + index) % filteredUsers.count]
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
                                                        currentIndex = (currentIndex + 1) % filteredUsers.count
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
                        // 没有符合筛选条件的用户时的提示
                        VStack(spacing: 20) {
                            Image(systemName: selectedEducation == nil ? "person.2.slash" : "magnifyingglass")
                                .font(.system(size: 60))
                                .foregroundColor(.gray)
                            
                            if selectedEducation != nil {
                                Text("没有找到符合条件的人")
                                    .font(.title2)
                                    .foregroundColor(.gray)
                                Text("尝试调整筛选条件或稍后再来")
                                    .foregroundColor(.gray)
                                Button("清除筛选") {
                                    selectedEducation = nil
                                }
                                .padding(.top, 10)
                            } else {
                                Text("暂时没有更多推荐了")
                                    .font(.title2)
                                    .foregroundColor(.gray)
                                Text("稍后再来看看吧")
                                    .foregroundColor(.gray)
                            }
                        }
                        .frame(maxHeight: .infinity)
                    }
                    
                    // 底部操作按钮
                    HStack(spacing: 40) {
                        Button(action: {
                            // 不喜欢
                            withAnimation {
                                if !filteredUsers.isEmpty {
                                    let user = filteredUsers[currentIndex % filteredUsers.count]
                                    appState.dislikeUser(user)
                                    currentIndex = (currentIndex + 1) % filteredUsers.count
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
                                if !filteredUsers.isEmpty {
                                    let user = filteredUsers[currentIndex % filteredUsers.count]
                                    appState.likeUser(user)
                                    currentIndex = (currentIndex + 1) % filteredUsers.count
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
