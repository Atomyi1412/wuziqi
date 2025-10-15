# 五子棋游戏 Android APK

这是一个使用 Apache Cordova 将五子棋 Web 应用打包成 Android APK 的项目。

## 项目结构

```
mobile-app/
├── www/                    # Web应用文件
│   ├── index.html         # 主页面
│   ├── styles.css         # 样式文件
│   └── themes.html        # 主题页面
├── platforms/             # 平台特定文件
│   ├── android/           # Android平台文件
│   └── browser/           # 浏览器平台文件
├── plugins/               # Cordova插件
├── config.xml             # Cordova配置文件
├── package.json           # 项目依赖
├── build.bat              # 构建脚本
└── README.md              # 说明文档
```

## 快速开始

### 1. 使用构建脚本（推荐）

双击运行 `build.bat` 文件，选择相应的构建选项：

- **选项1**: 构建浏览器版本（用于测试）
- **选项2**: 构建Android调试版APK
- **选项3**: 运行浏览器版本进行测试

### 2. 手动构建

#### 浏览器版本（测试用）

```bash
# 构建浏览器版本
cordova build browser

# 运行浏览器版本
cordova serve browser
```

访问 http://localhost:8000 进行测试

#### Android APK

```bash
# 构建调试版APK
cordova build android --debug

# 构建发布版APK（需要签名）
cordova build android --release
```

## 环境要求

### 基础环境
- Node.js (已安装)
- Cordova CLI (已安装)

### Android APK构建环境
要构建Android APK，还需要：

1. **Java Development Kit (JDK)**
   - 推荐 JDK 8 或 JDK 11

2. **Android Studio 和 Android SDK**
   - 下载并安装 Android Studio
   - 通过 SDK Manager 安装必要的 SDK 组件

3. **环境变量配置**
   ```bash
   # 设置 ANDROID_HOME 环境变量
   ANDROID_HOME=C:\Users\YourName\AppData\Local\Android\Sdk
   
   # 添加到 PATH
   PATH=%PATH%;%ANDROID_HOME%\tools;%ANDROID_HOME%\platform-tools
   ```

## 已安装的插件

- `cordova-plugin-whitelist` - 网络访问控制
- `cordova-plugin-splashscreen` - 启动画面
- `cordova-plugin-statusbar` - 状态栏控制
- `cordova-plugin-device` - 设备信息

## 游戏功能

✅ **已验证功能**：
- 普通五子棋模式
- 技能模式（神来之笔等技能）
- 拖拽和缩放功能
- 触摸优化
- 移动端适配
- 主题切换

## 构建输出

### 浏览器版本
- 位置: `platforms/browser/www/`
- 用途: 本地测试和调试

### Android APK
- 调试版: `platforms/android/app/build/outputs/apk/debug/app-debug.apk`
- 发布版: `platforms/android/app/build/outputs/apk/release/app-release.apk`

## 安装和测试

### 在Android设备上安装

1. 启用"开发者选项"和"USB调试"
2. 连接设备到电脑
3. 使用ADB安装：
   ```bash
   adb install platforms/android/app/build/outputs/apk/debug/app-debug.apk
   ```

或者直接将APK文件传输到设备上进行安装。

### 测试要点

- [ ] 游戏界面正常显示
- [ ] 触摸下棋功能正常
- [ ] 拖拽和缩放功能正常
- [ ] 技能功能正常使用
- [ ] 主题切换功能正常
- [ ] 游戏逻辑正确（五子连珠判断）

## 故障排除

### 常见问题

1. **Android SDK 未找到**
   - 确保安装了 Android Studio
   - 正确设置 ANDROID_HOME 环境变量

2. **构建失败**
   - 检查 Java 版本兼容性
   - 确保 Android SDK 组件完整

3. **APK 无法安装**
   - 检查设备是否允许安装未知来源应用
   - 确保APK文件完整

### 获取帮助

如果遇到问题，可以：
1. 查看构建日志获取详细错误信息
2. 检查 Cordova 官方文档
3. 验证环境配置是否正确

## 版本信息

- Cordova: 12.0.0
- Node.js: 22.20.0
- 目标 Android SDK: 35
- 最低 Android 版本: API 21 (Android 5.0)