import SwiftUI

struct LoginView: View {
    @EnvironmentObject var appState: AppState
    @State private var phoneNumber = ""
    @State private var verificationCode = ""
    @State private var showVerification = false
    @State private var countdown = 60
    @State private var timer: Timer? = nil
    
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
        }
    }
    
    private func getVerificationCode() {
        // 这里应该调用发送验证码的API
        print("发送验证码到: \(phoneNumber)")
        
        // 显示验证码输入框
        showVerification = true
        
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
        // 这里应该调用登录API验证验证码
        print("登录: \(phoneNumber), 验证码: \(verificationCode)")
        
        // 模拟登录成功
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            withAnimation {
                appState.showLogin = false
            }
        }
    }
    
    }
    .onDisappear {
        timer?.invalidate()
    }
}

#Preview {
    LoginView()
        .environmentObject(AppState())
}
