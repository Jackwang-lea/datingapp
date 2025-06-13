import SwiftUI

// MARK: - Main View
struct DiscoverView: View {
    @EnvironmentObject var appState: AppState
    @State private var currentUserIndex = 0

    private var currentUser: User? {
        guard !appState.users.isEmpty else { return nil }
        return appState.users[currentUserIndex]
    }

    var body: some View {
        NavigationView {
            ZStack {
                if let user = currentUser {
                    UserProfileView(user: user, onAction: handleUserAction)
                } else {
                    NoUsersView()
                }
            }
            .navigationBarHidden(true)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }

    private func handleUserAction(_ action: UserAction) {
        guard let user = currentUser else { return }

        switch action {
        case .like:
            appState.likeUser(user)
        case .dislike:
            appState.dislikeUser(user)
        case .superlike:
            // Placeholder for superlike logic
            print("Superliked \(user.name)")
        }

        // Move to the next user
        if currentUserIndex < appState.users.count - 1 {
            currentUserIndex += 1
        } else {
            // Loop back or show end of list
            currentUserIndex = 0
        }
    }
}

enum UserAction { case like, dislike, superlike }

// MARK: - Profile View
struct UserProfileView: View {
    let user: User
    let onAction: (UserAction) -> Void

    var body: some View {
        ZStack(alignment: .topLeading) {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 0) {
                    ProfileHeaderView(user: user)
                    
                    VStack(spacing: 20) {
                        AboutMeSection(user: user)
                        MBTISection()
                        LifeStageSection()
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(20, corners: [.topLeft, .topRight])
                    .padding(.horizontal)
                    .offset(y: -20)
                }
                .padding(.bottom, 180)
            }
            .background(Color(.systemGray6))
            

            TopLeftBackButton()
            
            FloatingActionButtons(onAction: onAction)
        }
    }
}

// MARK: - Profile Subviews
private struct ProfileHeaderView: View {
    let user: User

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Image(user.imageNames.first ?? "photo-placeholder")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: UIScreen.main.bounds.height * 0.65)
                .clipped()

            VStack(alignment: .leading, spacing: 8) {
                Text("\(user.name), \(user.age)")
                    .font(.largeTitle).bold()
                    .foregroundColor(.white)
                Text("互联网\n香港大学") // Placeholder
                    .font(.title3)
                    .foregroundColor(.white)
            }
            .padding(20)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(LinearGradient(colors: [.clear, .black.opacity(0.8)], startPoint: .top, endPoint: .bottom))
        }
    }
}

private struct AboutMeSection: View {
    let user: User
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("关于我..").font(.headline)
            HStack {
                InfoTagView(icon: "ruler", text: "163cm")
                InfoTagView(icon: "moon.stars", text: "双鱼座")
                InfoTagView(icon: "house", text: "家乡·海外")
            }
            InfoTagView(icon: "target", text: "目的·脱单/认识新朋友")
            Divider()
            Text("我的日常..").font(.headline)
            Text("🎵 📜 🌶️\n高能量实习中\n低能量论文中")
            Image(user.imageNames.last ?? "photo-placeholder")
                .resizable().aspectRatio(contentMode: .fill)
                .frame(height: 300).clipped().cornerRadius(15)
        }
    }
}

private struct MBTISection: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack { Text("我的MBTI").font(.headline); Spacer(); Text("ENFJ领导者").bold() }
            MBTIBarView(label: "外倾", oppositeLabel: "内倾", value: 0.7, color: .blue)
            MBTIBarView(label: "抽象", oppositeLabel: "具象", value: 0.6, color: .orange)
            MBTIBarView(label: "感性", oppositeLabel: "理性", value: 1.0, color: .purple)
            MBTIBarView(label: "随性", oppositeLabel: "计划", value: 0.4, color: .cyan)
        }
    }
}

private struct LifeStageSection: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("关于人生阶段").font(.headline)
            Text("当前人生阶段，我的精力分配：").font(.subheadline).foregroundColor(.gray)
            LifeStageBarView()
        }
    }
}

// MARK: - UI Components
private struct FloatingActionButtons: View {
    let onAction: (UserAction) -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            HStack {
                Spacer()
                VStack(spacing: 25) {
                    ActionButton(icon: "sparkles", color: .blue) { onAction(.superlike) }
                    ActionButton(icon: "heart.fill", color: .red) { onAction(.like) }
                    ActionButton(icon: "xmark", color: .white, foregroundColor: .gray) { onAction(.dislike) }
                }
                .padding(.trailing, 20)
                .padding(.bottom, 90)
            }
        }
    }
}

private struct ActionButton: View {
    let icon: String
    let color: Color
    var foregroundColor: Color = .white
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: icon)
                .font(.system(size: 25, weight: .bold))
                .foregroundColor(foregroundColor)
                .frame(width: 60, height: 60)
                .background(color)
                .clipShape(Circle())
                .shadow(radius: 5)
        }
    }
}

private struct TopLeftBackButton: View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        VStack {
            HStack {
                Button(action: { presentationMode.wrappedValue.dismiss() }) {
                    Image(systemName: "chevron.left")
                        .font(.title2).bold()
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.black.opacity(0.4))
                        .clipShape(Circle())
                }
                .padding([.leading, .top])
                Spacer()
            }
            Spacer()
        }
    }
}

private struct InfoTagView: View {
    let icon: String
    let text: String
    var body: some View {
        HStack { Image(systemName: icon); Text(text) }
            .font(.subheadline).padding(8)
            .background(Color.gray.opacity(0.15))
            .cornerRadius(10)
    }
}

private struct MBTIBarView: View {
    let label: String, oppositeLabel: String, value: CGFloat, color: Color
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack { Text("\(label) \(Int(value*100))%").bold(); Spacer(); Text("\(Int((1-value)*100))% \(oppositeLabel)").bold() }
                .font(.caption).foregroundColor(color)
            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    Capsule().fill(Color.gray.opacity(0.2))
                    Capsule().fill(color).frame(width: geo.size.width * value)
                }
            }.frame(height: 12)
        }
    }
}

private struct LifeStageBarView: View {
    let stages = [
        (label: "事业", value: 0.4, color: Color.blue),
        (label: "友情", value: 0.2, color: Color.green),
        (label: "爱情", value: 0.1, color: Color.red),
        (label: "成长", value: 0.3, color: Color.purple)
    ]
    var body: some View {
        GeometryReader { geo in
            VStack(alignment: .leading, spacing: 5) {
                HStack(spacing: 0) {
                    ForEach(stages, id: \.label) { stage in
                        Rectangle().fill(stage.color).frame(width: geo.size.width * stage.value)
                    }
                }.frame(height: 15).clipShape(Capsule())
                HStack(spacing: 0) {
                    ForEach(stages, id: \.label) { stage in
                        Text("\(stage.label) \(Int(stage.value*100))").font(.caption).bold()
                            .frame(width: geo.size.width * stage.value)
                    }
                }
            }
        }.frame(height: 35)
    }
}

private struct NoUsersView: View {
    var body: some View {
        VStack {
            Image(systemName: "person.2.slash").font(.largeTitle)
            Text("暂时没有更多推荐了").font(.title2)
            Text("稍后再来看看吧")
        }.foregroundColor(.gray)
    }
}



struct DiscoverView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverView()
            .environmentObject(AppState.mock)
    }
}
