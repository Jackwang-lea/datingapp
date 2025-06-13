import SwiftUI
import Kingfisher

struct UserCardView: View {
    let user: User
    @State private var currentIndex = 0
    @State private var isShowingImageBrowser = false
    @State private var isLiked = false
    @State private var isDisliked = false
    
    // 卡片尺寸
    private let cardWidth = UIScreen.main.bounds.width - 40
    private let cardHeight: CGFloat = 500
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            TabView(selection: $currentIndex) {
                ForEach(0..<user.photos.count, id: \.self) { index in
                    KFImage(URL(string: user.photos[index]))
                        .resizable()
                        .scaledToFill()
                        .frame(width: cardWidth, height: cardHeight)
                        .clipped()
                        .tag(index)
                        .onTapGesture {
                            isShowingImageBrowser = true
                        }
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .frame(height: cardHeight)
            .cornerRadius(15)
            .shadow(radius: 5)
            
            // 渐变遮罩
            LinearGradient(
                gradient: Gradient(colors: [.clear, .black.opacity(0.7)]),
                startPoint: .top,
                endPoint: .bottom
            )
            .frame(height: cardHeight / 2)
            .offset(y: cardHeight / 2)
            .cornerRadius(15)
            
            // 页码指示器
            if user.photos.count > 1 {
                HStack(spacing: 5) {
                    ForEach(0..<user.photos.count, id: \.self) { index in
                        Circle()
                            .fill(currentIndex == index ? Color.white : Color.white.opacity(0.5))
                            .frame(width: 6, height: 6)
                    }
                }
                .padding(8)
                .background(Color.black.opacity(0.4))
                .cornerRadius(10)
                .padding(.top, 10)
                .frame(maxWidth: .infinity)
            }
            
            // 用户信息
            VStack(alignment: .leading, spacing: 8) {
                // 姓名和年龄
                HStack(alignment: .bottom, spacing: 5) {
                    Text(user.name)
                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(.white)
                    
                    Text("\(user.age)岁")
                        .font(.title3)
                        .foregroundColor(.white)
                        .padding(.bottom, 2)
                }
                
                // 位置
                HStack(spacing: 4) {
                    Image(systemName: "mappin.and.ellipse")
                        .font(.caption)
                        .foregroundColor(.white)
                    
                    Text(user.location)
                        .font(.subheadline)
                        .foregroundColor(.white)
                }
                
                // 兴趣标签
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        ForEach(user.interests.prefix(5), id: \.self) { interest in
                            Text(interest)
                                .font(.caption)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(Color.white.opacity(0.2))
                                .foregroundColor(.white)
                                .cornerRadius(15)
                        }
                    }
                }
                .padding(.top, 8)
                
                // 个人简介
                Text(user.bio)
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .lineLimit(3)
                    .padding(.top, 8)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [.clear, .black.opacity(0.8)]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .cornerRadius(15, corners: [.bottomLeft, .bottomRight])
                .padding(.top, cardHeight / 2)
            )
            .offset(y: cardHeight / 2)
            
            // 喜欢/不喜欢指示器
            if isLiked || isDisliked {
                VStack {
                    Text(isLiked ? "喜欢" : "跳过")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(isLiked ? .green : .red)
                        .padding()
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(10)
                        .rotationEffect(.degrees(isLiked ? -15 : 15))
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity, alignment: isLiked ? .leading : .trailing)
                .padding(.horizontal, 30)
                .padding(.top, 30)
                .opacity(isLiked || isDisliked ? 1 : 0)
                .animation(.spring(), value: isLiked || isDisliked)
            }
        }
        .frame(width: cardWidth, height: cardHeight)
        .cornerRadius(15)
        .shadow(radius: 10)
        .onDisappear {
            isLiked = false
            isDisliked = false
        }
        .fullScreenCover(isPresented: $isShowingImageBrowser) {
            ImageBrowser(
                isPresented: $isShowingImageBrowser,
                imageUrls: user.photos,
                selectedIndex: $currentIndex
            )
        }
    }
    
    // 触发喜欢动画
    func like() {
        withAnimation(.spring()) {
            isLiked = true
            isDisliked = false
        }
    }
    
    // 触发不喜欢动画
    func dislike() {
        withAnimation(.spring()) {
            isLiked = false
            isDisliked = true
        }
    }
}

// 圆角矩形扩展
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

// 预览
struct UserCardView_Previews: PreviewProvider {
    static var previewUser: User {
        User(
            id: "1",
            name: "张明",
            age: 28,
            bio: "热爱生活，喜欢旅行和美食，寻找志同道合的伴侣。希望找到一个能一起探索世界的人。",
            photos: [
                "https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=800&q=80",
                "https://images.unsplash.com/photo-1531746020798-e6953c120e11?w=800&q=80"
            ],
            interests: ["旅行", "美食", "摄影", "电影", "音乐"],
            location: "北京市朝阳区",
            gender: .male,
            preference: .female,
            education: .bachelor,
            lastActive: Date()
        )
    }
    
    static var previews: some View {
        UserCardView(user: previewUser)
            .frame(width: UIScreen.main.bounds.width - 40, height: 500)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
