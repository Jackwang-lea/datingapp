import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var appState: AppState
    @State private var showEditProfile = false
    @State private var showSettings = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // 头像和基本信息
                    VStack(spacing: 15) {
                        // 头像
                        ZStack(alignment: .bottomTrailing) {
                            if let user = appState.currentUser, !user.photos.isEmpty {
                                Image(user.photos[0])
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 120, height: 120)
                                    .clipShape(Circle())
                            } else {
                                Circle()
                                    .fill(Color.gray.opacity(0.3))
                                    .frame(width: 120, height: 120)
                                    .overlay(
                                        Image(systemName: "person.fill")
                                            .font(.system(size: 50))
                                            .foregroundColor(.gray)
                                    )
                            }
                            
                            // 编辑按钮
                            Button(action: {
                                showEditProfile = true
                            }) {
                                Image(systemName: "pencil.circle.fill")
                                    .font(.system(size: 30))
                                    .foregroundColor(.pink)
                                    .background(Color.white.clipShape(Circle()))
                            }
                            .offset(x: 5, y: 5)
                        }
                        
                        // 用户名和年龄
                        if let user = appState.currentUser {
                            Text("\(user.name), \(user.age)")
                                .font(.title2)
                                .fontWeight(.bold)
                            
                            // 位置
                            HStack {
                                Image(systemName: "mappin.and.ellipse")
                                Text(user.location)
                            }
                            .foregroundColor(.gray)
                        }
                    }
                    .padding(.top, 30)
                    
                    // 关于我
                    VStack(alignment: .leading, spacing: 10) {
                        Text("关于我")
                            .font(.headline)
                            .padding(.leading)
                        
                        Text(appState.currentUser?.bio ?? "")
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                            .padding(.horizontal)
                    }
                    
                    // 兴趣爱好
                    VStack(alignment: .leading, spacing: 10) {
                        Text("兴趣爱好")
                            .font(.headline)
                            .padding(.leading)
                        
                        if let interests = appState.currentUser?.interests, !interests.isEmpty {
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack {
                                    ForEach(interests, id: \.self) { interest in
                                        Text(interest)
                                            .font(.subheadline)
                                            .padding(.horizontal, 15)
                                            .padding(.vertical, 8)
                                            .background(Color.pink.opacity(0.1))
                                            .foregroundColor(.pink)
                                            .cornerRadius(15)
                                    }
                                }
                                .padding(.horizontal)
                            }
                        } else {
                            Text("暂无兴趣爱好")
                                .foregroundColor(.gray)
                                .padding()
                                .frame(maxWidth: .infinity)
                        }
                    }
                    .padding(.top, 10)
                    
                    // 照片墙
                    VStack(alignment: .leading, spacing: 10) {
                        Text("照片")
                            .font(.headline)
                            .padding(.leading)
                        
                        if let photos = appState.currentUser?.photos, !photos.isEmpty {
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 15) {
                                    ForEach(photos, id: \.self) { photo in
                                        Image(photo)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 120, height: 160)
                                            .clipped()
                                            .cornerRadius(10)
                                    }
                                }
                                .padding(.horizontal)
                            }
                        } else {
                            Text("暂无照片")
                                .foregroundColor(.gray)
                                .padding()
                                .frame(maxWidth: .infinity)
                        }
                    }
                    .padding(.top, 10)
                    
                    Spacer()
                }
            }
            .navigationTitle("我的资料")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showSettings = true
                    }) {
                        Image(systemName: "gearshape")
                            .font(.system(size: 20))
                    }
                }
            }
            .sheet(isPresented: $showEditProfile) {
                // 编辑资料视图
                Text("编辑资料")
            }
            .sheet(isPresented: $showSettings) {
                // 设置视图
                SettingsView()
            }
        }
    }
}

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("账号")) {
                    NavigationLink(destination: Text("编辑资料")) {
                        Text("编辑个人资料")
                    }
                    
                    NavigationLink(destination: Text("偏好设置")) {
                        Text("匹配偏好")
                    }
                    
                    NavigationLink(destination: Text("账号设置")) {
                        Text("账号设置")
                    }
                }
                
                Section(header: Text("其他")) {
                    NavigationLink(destination: Text("帮助与支持")) {
                        Text("帮助与支持")
                    }
                    
                    NavigationLink(destination: Text("关于")) {
                        Text("关于我们")
                    }
                    
                    Button(action: {
                        // 退出登录
                        appState.currentUser = nil
                        appState.showLogin = true
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("退出登录")
                            .foregroundColor(.red)
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("设置")
            .navigationBarItems(trailing: Button("完成") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

#Preview {
    ProfileView()
        .environmentObject(AppState())
}
