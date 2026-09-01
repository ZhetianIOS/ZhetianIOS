# 遮天 iOS App 壳子项目

这是一个 WKWebView 壳子 App，加载游戏服务器 http://155.103.156.139:81/index.html

## 使用步骤（完全免费，不需要Mac）

### 第一步：上传到GitHub

1. 在 GitHub 注册/登录账号：https://github.com
2. 点击右上角 "+" → "New repository"
3. 仓库名填 `ZhetianIOS`，选 Public，点 Create repository
4. 把本项目所有文件上传到仓库（可以拖进去）

### 第二步：自动编译IPA

1. 上传后，进入仓库的 **Actions** 页面
2. 会看到 "Build iOS IPA" workflow 正在运行（绿圈转动）
3. 等待2-3分钟，变成绿勾 ✓ 表示编译成功
4. 点击进入workflow页面，底部 **Artifacts** 区域下载 `ZhetianIOS-ipa.zip`
5. 解压得到 `ZhetianIOS.ipa`

### 第三步：用Sideloadly签名安装（Windows）

1. 下载安装 Sideloadly（免费）：https://sideloadly.io
2. 安装 iTunes（Windows版）：https://www.apple.com/itunes/
3. 用USB连接iPhone到电脑，信任电脑
4. 打开 Sideloadly：
   - 左边拖入 `ZhetianIOS.ipa`
   - 填入你的 Apple ID（免费的就行）
   - 点 Start
5. iPhone上会出现新App图标"ZhetianIOS"
6. **重要**：iPhone上设置 → 通用 → VPN与设备管理 → 信任你的Apple ID

### 第四步：每7天重签

免费Apple ID签名的App每7天过期，需要重新安装：
- 重新打开 Sideloadly，同样步骤再签一次即可
- App内数据不会丢失

## 项目结构

```
ZhetianIOS/
├── ZhetianIOS.xcodeproj/     # Xcode项目
│   └── project.pbxproj
├── ZhetianIOS/               # 源代码
│   ├── AppDelegate.swift     # App入口
│   ├── SceneDelegate.swift   # 场景管理
│   ├── ViewController.swift  # WKWebView加载游戏
│   └── Info.plist            # 配置（已允许HTTP/WS）
└── .github/workflows/
    └── build.yml             # GitHub Actions自动编译
```

## 修改游戏地址

如果游戏服务器地址变了，修改 `ZhetianIOS/ViewController.swift` 第12行：
```swift
let gameURL = "http://你的服务器IP:端口/index.html"
```

## Bundle ID

默认 Bundle ID 是 `com.zhetian.game`，免费Apple ID会自动加前缀变成 `com.你的AppleID.zhetian-game`，不影响使用。
