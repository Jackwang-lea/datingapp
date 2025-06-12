<div align="center">

# 约会应用 (Dating App)

[![Swift Version](https://img.shields.io/badge/Swift-5.5+-orange.svg)](https://swift.org/)
[![Platform](https://img.shields.io/badge/Platforms-iOS%2015%2B-blue.svg)](https://www.apple.com/ios/)
[![License](https://img.shields.io/badge/License-MIT-lightgrey.svg)](LICENSE)
[![Twitter](https://img.shields.io/badge/Twitter-@Jackwang--lea-blue.svg?style=flat)](https://twitter.com/Jackwang-lea)

一个基于 SwiftUI 的现代移动端约会应用，提供用户匹配、聊天和个人资料管理等功能。

![App Screenshot](https://via.placeholder.com/300x600.png?text=Dating+App+Screenshot)

</div>

## 功能特点

- 📱 手机号验证码登录
- 👥 用户卡片浏览（支持左右滑动喜欢/不喜欢）
- 🖼️ 图片浏览器（支持缩放和滑动）
- ❤️ 智能匹配系统
- 🎓 学历筛选功能
- 📍 地理位置显示
- 💬 实时聊天功能
- 🔍 高级筛选条件
- 🎨 精美动画效果
- 📱 响应式设计，完美适配各种 iOS 设备

## 技术栈

### 核心技术栈

| 技术 | 版本 | 用途 |
|------|------|------|
| ![Swift](https://img.shields.io/badge/Swift-5.5+-orange) | 5.5+ | 开发语言 |
| ![iOS](https://img.shields.io/badge/iOS-15.0+-blue) | 15.0+ | 目标平台 |
| ![Xcode](https://img.shields.io/badge/Xcode-13.0+-blue) | 13.0+ | 开发工具 |
| ![SwiftUI](https://img.shields.io/badge/UI-SwiftUI-blue) | 3.0+ | UI框架 |
| ![Combine](https://img.shields.io/badge/Combine-Reactive-blue) | - | 响应式编程 |
| ![MVVM](https://img.shields.io/badge/Architecture-MVVM-blueviolet) | - | 架构模式 |
| ![SPM](https://img.shields.io/badge/SPM-Compatible-brightgreen) | - | 依赖管理 |

### 主要功能模块

- **用户认证**：手机号验证码登录
- **发现页**：滑动浏览推荐用户
- **匹配系统**：双向喜欢自动匹配
- **聊天功能**：实时消息通信
- **个人中心**：个人信息管理
- **筛选系统**：多条件筛选用户

## 项目结构

```
Dating/
├── Dating/
│   ├── Models/                 # 数据模型
│   │   ├── User.swift          # 用户模型
│   │   ├── Match.swift         # 匹配模型
│   │   └── Education.swift     # 学历模型
│   │
│   ├── ViewModels/           # 视图模型
│   │   └── AppState.swift      # 应用状态管理
│   │
│   ├── Views/                # 视图
│   │   ├── Components/         # 可重用组件
│   │   │   ├── UserCardView.swift    # 用户卡片
│   │   │   ├── ImageBrowser.swift    # 图片浏览器
│   │   │   └── FilterView.swift      # 筛选视图
│   │   │
│   │   ├── DiscoverView.swift  # 发现页
│   │   ├── LoginView.swift     # 登录页
│   │   ├── MatchesView.swift   # 匹配页
│   │   ├── MessagesView.swift  # 消息页
│   │   └── ProfileView.swift   # 个人中心
│   │
│   └── DatingApp.swift       # 应用入口
│
├── Assets.xcassets/          # 图片资源
└── Preview Content/            # 预览内容
```

## 快速开始

### 环境要求

- Xcode 13.0 或更高版本
- iOS 15.0+ 设备或模拟器
- Swift 5.5+

### 安装步骤

1. 克隆仓库
   ```bash
   git clone https://github.com/Jackwang-lea/datingapp.git
   cd datingapp
   ```

2. 打开项目
   ```bash
   open Dating.xcodeproj
   ```

3. 构建并运行项目 (⌘ + R)

## 使用说明

1. **登录**
   - 输入手机号
   - 获取验证码（测试验证码：123456）
   - 输入验证码登录

2. **浏览用户**
   - 左右滑动卡片表示喜欢/不喜欢
   - 点击图片查看大图
   - 上滑查看用户详细信息

3. **匹配**
   - 当双方互相喜欢时，会形成匹配
   - 可以在匹配列表中查看已匹配的用户

## 开发

### 代码规范

- 使用 SwiftLint 保持代码风格一致
- 遵循 Swift API 设计指南
- 使用有意义的变量和函数名



## 致谢

- 感谢所有贡献者
- 使用 [Kingfisher](https://github.com/onevcat/Kingfisher) 进行图片加载
- 使用 Unsplash 提供的免费图片资源
