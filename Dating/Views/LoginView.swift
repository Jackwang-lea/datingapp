import SwiftUI

struct LoginView: View {
    @EnvironmentObject var appState: AppState
    @State private var phoneNumber = ""
    @State private var verificationCode = ""
    @State private var showVerification = false
    @State private var countdown = 60
    @State private var timer: Timer? = nil
    @State private var isLoading = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    // 登录请求模型
    struct LoginRequest: Codable {
        let phoneNumber: String
        let verificationCode: String
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                // 应用图标和欢迎语
                VStack(spacing: 20) {
                    Image(systemName: "heart.fill")
                        .font(.system(size: 60))
                        .foregroundColor(.pink)
                    
                    Text("欢迎使用心动")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Text("遇见你的心动瞬间")
                        .foregroundColor(.gray)
                }
                .padding(.top, 60)
                
                Spacer()
                
                // 登录表单
                VStack(spacing: 20) {
                    if !showVerification {
                        // 手机号输入
                        VStack(alignment: .leading, spacing: 8) {
                            Text("手机号")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            
                            TextField("请输入手机号", text: $phoneNumber)
                                .keyboardType(.phonePad)
                                .padding()
                                .background(Color(.systemGray6))
                                .cornerRadius(10)
                        }
                        
                        // 获取验证码按钮
                        Button(action: getVerificationCode) {
                            Text("获取验证码")
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(phoneNumber.count == 11 ? Color.pink : Color.gray)
                                .cornerRadius(10)
                        }
                        .disabled(phoneNumber.count != 11)
                        .padding(.top, 20)
                    } else {
                        // 验证码输入
                        VStack(spacing: 20) {
                            Text("验证码已发送至 +86 \(phoneNumber)")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            
                            TextField("请输入验证码", text: $verificationCode)
                                .keyboardType(.numberPad)
                                .multilineTextAlignment(.center)
                                .font(.title2)
                                .padding()
                                .background(Color(.systemGray6))
                                .cornerRadius(10)
                            
                            HStack {
                                Text("收不到验证码？")
                                
                                if countdown < 60 {
                                    Text("\(countdown)秒后重试")
                                        .foregroundColor(.gray)
                                } else {
                                    Button(action: getVerificationCode) {
                                        Text("重新获取")
                                            .foregroundColor(.pink)
                                    }
                                }
                            }
                            .font(.caption)
                            .padding(.top, 10)
                            
                            // 登录按钮
                            Button(action: login) {
                                Text("登录")
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(verificationCode.count == 6 ? Color.pink : Color.gray)
                                    .cornerRadius(10)
                            }
                            .disabled(verificationCode.count != 6)
                            .padding(.top, 20)
                        }
                    }
                    
                    // 其他登录方式
                    VStack(spacing: 15) {
                        HStack {
                            Rectangle()
                                .frame(height: 1)
                                .foregroundColor(.gray.opacity(0.3))
                            
                            Text("其他登录方式")
                                .font(.caption)
                                .foregroundColor(.gray)
                                .padding(.horizontal, 10)
                            
                            Rectangle()
                                .frame(height: 1)
                                .foregroundColor(.gray.opacity(0.3))
                        }
                        
                        HStack(spacing: 30) {
                            // 微信登录
                            Button(action: {}) {
                                VStack {
                                    Image(systemName: "message.fill")
                                        .font(.title2)
                                        .padding(15)
                                        .background(Color.green.opacity(0.1))
                                        .clipShape(Circle())
                                    
                                    Text("微信")
                                        .font(.caption)
                                        .foregroundColor(.primary)
                                }
                            }
                            
                            // 苹果登录
                            Button(action: {}) {
                                VStack {
                                    Image(systemName: "applelogo")
                                        .font(.title2)
                                        .padding(15)
                                        .background(Color.black.opacity(0.1))
                                        .clipShape(Circle())
                                    
                                    Text("Apple")
                                        .font(.caption)
                                        .foregroundColor(.primary)
                                }
                            }
                        }
                    }
                    .padding(.top, 40)
                }
                .padding(.horizontal, 30)
                
                Spacer()
                
                // 用户协议和隐私政策
                HStack(spacing: 0) {
                    Text("登录即表示您同意")
                        .font(.caption2)
                        .foregroundColor(.gray)
                    
                    Button(action: {}) {
                        Text("用户协议")
                            .font(.caption2)
                            .foregroundColor(.pink)
                    }
                    
                    Text("和")
                        .font(.caption2)
                        .foregroundColor(.gray)
                    
                    Button(action: {}) {
                        Text("隐私政策")
                            .font(.caption2)
                            .foregroundColor(.pink)
                    }
                }
                .padding(.bottom, 30)
            }
            .navigationBarHidden(true)
            .onDisappear {
                stopTimer()
            }
            .disabled(isLoading)
            .opacity(isLoading ? 0.7 : 1.0)
            .overlay {
                if isLoading {
                    ProgressView()
                        .scaleEffect(1.5)
                }
            }
            .alert("提示", isPresented: $showAlert) {
                Button("确定", role: .cancel) {}
            } message: {
                Text(alertMessage)
            }
        }
    }
    
    // 模拟验证码（用于开发测试）
    private let testVerificationCode = "123456"
    
    private func getVerificationCode() {
        // 验证手机号格式
        guard phoneNumber.count == 11 else {
            alertMessage = "请输入有效的手机号"
            showAlert = true
            return
        }
        
        // 显示验证码输入框
        showVerification = true
        
        // 在开发环境中，直接显示测试验证码
        #if DEBUG
        alertMessage = "测试验证码: \(testVerificationCode)"
        showAlert = true
        verificationCode = testVerificationCode // 自动填充验证码
        #else
        // 生产环境调用发送验证码的API
        print("发送验证码到: \(phoneNumber)")
        #endif
        
        // 开始倒计时
        startCountdown()
    }
    
    private func startCountdown() {
        countdown = 60
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if countdown > 0 {
                countdown -= 1
            } else {
                timer?.invalidate()
            }
        }
    }
    
    private func login() {
        // 1. 验证输入
        guard phoneNumber.count == 11 else {
            alertMessage = "请输入有效的手机号"
            showAlert = true
            return
        }
        
        guard verificationCode.count == 6 else {
            alertMessage = "请输入6位验证码"
            showAlert = true
            return
        }
        
        // 2. 显示加载状态
        isLoading = true
        
        // 3. 准备登录请求
        _ = LoginRequest(
            phoneNumber: phoneNumber,
            verificationCode: verificationCode
        )
        
        Task {
            do {
                // 模拟网络请求延迟
                try await Task.sleep(nanoseconds: 1_000_000_000)
                
                // 模拟成功响应
                DispatchQueue.main.async {
                    // 保存登录状态
                    UserDefaults.standard.set(true, forKey: "isLoggedIn")
                    UserDefaults.standard.set("模拟用户ID", forKey: "userId")
                    
                    // 更新应用状态
                    withAnimation {
                        // 确保先设置 isLoggedIn 为 true
                        self.appState.isLoggedIn = true
                        self.appState.showLogin = false
                        
                        // 确保用户数据已加载
                        if self.appState.currentUser == nil {
                            self.appState.loadMockData()
                        }
                    }
                    
                    self.isLoading = false
                }
            } catch {
                // 处理错误
                DispatchQueue.main.async {
                    alertMessage = "登录失败: \(error.localizedDescription)"
                    showAlert = true
                    isLoading = false
                }
            }
        }
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
}

#Preview {
    LoginView()
        .environmentObject(AppState())
}
