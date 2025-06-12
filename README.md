<div align="center">

# 约会应用 (Dating App)

[![Swift Version](https://img.shields.io/badge/Swift-5.5+-orange.svg)](https://swift.org/)
[![Platform](https://img.shields.io/badge/Platforms-iOS%2015%2B-blue.svg)](https://www.apple.com/ios/)
[![License](https://img.shields.io/badge/License-MIT-lightgrey.svg)](LICENSE)
[![Twitter](https://img.shields.io/badge/Twitter-@Jackwang--lea-blue.svg?style=flat)](https://twitter.com/Jackwang-lea)

一个基于 SwiftUI 的现代移动端约会应用，提供用户匹配、聊天和个人资料管理等功能。

</div>

## 功能特点

- 手机号验证码登录
- 用户卡片浏览（支持左右滑动喜欢/不喜欢）
- 图片浏览器（支持缩放和滑动）
- 匹配列表
- 个人资料管理
- 响应式设计，适配各种 iOS 设备

## 技术栈

| 技术 | 版本 |
|------|------|
| ![Swift](https://img.shields.io/badge/Swift-5.5+-orange) | 5.5+ |
| ![iOS](https://img.shields.io/badge/iOS-15.0+-blue) | 15.0+ |
| ![Xcode](https://img.shields.io/badge/Xcode-13.0+-blue) | 13.0+ |
| ![SwiftUI](https://img.shields.io/badge/UI-SwiftUI-blue) | 3.0+ |
| ![Architecture](https://img.shields.io/badge/Architecture-MVVM-blueviolet) | - |
| ![SPM](https://img.shields.io/badge/SPM-Compatible-brightgreen) | - |

## 项目结构

```
Dating/
├── Dating/
│   ├── Models/          # 数据模型
│   ├── ViewModels/      # 视图模型
│   ├── Views/           # 视图
│   │   ├── Components/  # 可重用组件
│   │   ├── DiscoverView.swift
│   │   ├── LoginView.swift
│   │   └── ...
│   └── DatingApp.swift  # 应用入口
├── Assets.xcassets/     # 图片资源
└── Preview Content/     # 预览内容
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

### 提交信息规范

使用 Conventional Commits 规范：

- `feat:` 新功能
- `fix:` 修复 bug
- `docs:` 文档更新
- `style:` 代码格式调整
- `refactor:` 代码重构
- `perf:` 性能优化
- `test:` 测试相关
- `chore:` 构建过程或辅助工具的变动

## 致谢

- 感谢所有贡献者
- 使用 [Kingfisher](https://github.com/onevcat/Kingfisher) 进行图片加载
- 使用 Unsplash 提供的免费图片资源
