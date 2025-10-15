# 五子棋游戏 Android APK 打包指南

## 1. 概述

本文档详细说明如何将现有的五子棋HTML5游戏打包为Android APK文件，使其能够在安卓手机上安装和运行。我们将使用Apache Cordova框架来实现Web应用到原生Android应用的转换。

## 2. 环境准备

### 2.1 必需软件安装

```bash
# 1. 安装Node.js (已安装)
# 确保Node.js版本 >= 14.x

# 2. 安装Cordova CLI
npm install -g cordova

# 3. 安装Android Studio
# 下载地址: https://developer.android.com/studio
# 安装后配置Android SDK

# 4. 配置环境变量
# ANDROID_HOME = Android SDK路径
# PATH 添加: %ANDROID_HOME%\tools, %ANDROID_HOME%\platform-tools
```

### 2.2 验证环境

```bash
# 检查Cordova安装
cordova --version

# 检查Android环境
cordova requirements android
```

## 3. 项目初始化

### 3.1 创建Cordova项目

```bash
# 在项目根目录执行
cd e:\trae\wuziqi
cordova create mobile-app com.wuziqi.game "五子棋游戏"
cd mobile-app
```

### 3.2 添加Android平台

```bash
# 添加Android平台支持
cordova platform add android

# 验证平台添加成功
cordova platform list
```

## 4. 配置文件设置

### 4.1 config.xml 配置

创建 `mobile-app/config.xml`：

```xml
<?xml version='1.0' encoding='utf-8'?>
<widget id="com.wuziqi.game" version="1.0.0" xmlns="http://www.w3.org/ns/widgets" xmlns:cdv="http://cordova.apache.org/ns/1.0">
    <name>五子棋游戏</name>
    <description>
        技能五子棋 - 支持普通模式和技能模式的五子棋游戏
    </description>
    <author email="your-email@example.com" href="https://github.com/Atomyi1412/wuziqi">
        五子棋开发团队
    </author>
    <content src="index.html" />
    
    <!-- 网络访问权限 -->
    <access origin="*" />
    <allow-intent href="http://*/*" />
    <allow-intent href="https://*/*" />
    
    <!-- Android特定配置 -->
    <platform name="android">
        <allow-intent href="market:*" />
        
        <!-- 图标配置 -->
        <icon density="ldpi" src="res/icon/android/ldpi.png" />
        <icon density="mdpi" src="res/icon/android/mdpi.png" />
        <icon density="hdpi" src="res/icon/android/hdpi.png" />
        <icon density="xhdpi" src="res/icon/android/xhdpi.png" />
        <icon density="xxhdpi" src="res/icon/android/xxhdpi.png" />
        <icon density="xxxhdpi" src="res/icon/android/xxxhdpi.png" />
        
        <!-- 启动画面配置 -->
        <splash density="land-ldpi" src="res/screen/android/splash-land-ldpi.png" />
        <splash density="land-mdpi" src="res/screen/android/splash-land-mdpi.png" />
        <splash density="land-hdpi" src="res/screen/android/splash-land-hdpi.png" />
        <splash density="land-xhdpi" src="res/screen/android/splash-land-xhdpi.png" />
        <splash density="port-ldpi" src="res/screen/android/splash-port-ldpi.png" />
        <splash density="port-mdpi" src="res/screen/android/splash-port-mdpi.png" />
        <splash density="port-hdpi" src="res/screen/android/splash-port-hdpi.png" />
        <splash density="port-xhdpi" src="res/screen/android/splash-port-xhdpi.png" />
        
        <!-- 应用权限 -->
        <uses-permission android:name="android.permission.INTERNET" />
        <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
        
        <!-- 性能优化 -->
        <preference name="android-minSdkVersion" value="21" />
        <preference name="android-targetSdkVersion" value="33" />
        <preference name="AndroidLaunchMode" value="singleTop" />
        <preference name="AndroidInsecureFileModeEnabled" value="true" />
    </platform>
    
    <!-- 全局首选项 -->
    <preference name="DisallowOverscroll" value="true" />
    <preference name="BackgroundColor" value="0xffffffff" />
    <preference name="HideKeyboardFormAccessoryBar" value="true" />
    <preference name="Orientation" value="default" />
    <preference name="SplashScreen" value="screen" />
    <preference name="SplashScreenDelay" value="3000" />
    <preference name="AutoHideSplashScreen" value="true" />
    <preference name="SplashShowOnlyFirstTime" value="false" />
    
    <!-- 移动端优化 -->
    <preference name="Fullscreen" value="false" />
    <preference name="StatusBarOverlaysWebView" value="false" />
    <preference name="StatusBarBackgroundColor" value="#000000" />
    <preference name="StatusBarStyle" value="lightcontent" />
</widget>
```

### 4.2 package.json 配置

创建 `mobile-app/package.json`：

```json
{
  "name": "wuziqi-mobile",
  "displayName": "五子棋游戏",
  "version": "1.0.0",
  "description": "技能五子棋移动应用",
  "main": "index.js",
  "scripts": {
    "build": "cordova build android",
    "build-release": "cordova build android --release",
    "run": "cordova run android",
    "prepare": "cordova prepare android"
  },
  "keywords": [
    "五子棋",
    "游戏",
    "cordova",
    "android"
  ],
  "author": "五子棋开发团队",
  "license": "MIT",
  "devDependencies": {
    "cordova-android": "^12.0.0"
  },
  "cordova": {
    "platforms": [
      "android"
    ],
    "plugins": {
      "cordova-plugin-whitelist": {},
      "cordova-plugin-splashscreen": {},
      "cordova-plugin-statusbar": {}
    }
  }
}
```

## 5. 资源文件准备

### 5.1 复制游戏文件

```bash
# 复制主要游戏文件到www目录
cp ../index.html www/
cp ../styles.css www/
cp ../themes.html www/

# 如果有其他资源文件也需要复制
# cp -r ../assets www/ (如果有assets目录)
```

### 5.2 图标文件准备

创建不同尺寸的应用图标：

```
res/icon/android/
├── ldpi.png (36x36)
├── mdpi.png (48x48)
├── hdpi.png (72x72)
├── xhdpi.png (96x96)
├── xxhdpi.png (144x144)
└── xxxhdpi.png (192x192)
```

### 5.3 启动画面准备

创建不同尺寸的启动画面：

```
res/screen/android/
├── splash-land-ldpi.png (320x200)
├── splash-land-mdpi.png (480x320)
├── splash-land-hdpi.png (800x480)
├── splash-land-xhdpi.png (1280x720)
├── splash-port-ldpi.png (200x320)
├── splash-port-mdpi.png (320x480)
├── splash-port-hdpi.png (480x800)
└── splash-port-xhdpi.png (720x1280)
```

## 6. 移动端优化

### 6.1 HTML文件修改

在 `www/index.html` 中添加移动端优化：

```html
<!-- 在<head>标签中添加 -->
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<meta name="format-detection" content="telephone=no">
<meta name="msapplication-tap-highlight" content="no">

<!-- Cordova脚本 -->
<script type="text/javascript" src="cordova.js"></script>

<!-- 设备就绪事件处理 -->
<script type="text/javascript">
document.addEventListener('deviceready', function() {
    console.log('Cordova设备就绪');
    
    // 隐藏启动画面
    if (navigator.splashscreen) {
        navigator.splashscreen.hide();
    }
    
    // 状态栏配置
    if (window.StatusBar) {
        StatusBar.styleDefault();
    }
}, false);
</script>
```

### 6.2 CSS移动端优化

确保现有的移动端触摸优化保持有效：

```css
/* 确保这些样式在移动应用中生效 */
body {
    -webkit-tap-highlight-color: transparent;
    -webkit-touch-callout: none;
    -webkit-user-select: none;
    user-select: none;
    touch-action: manipulation;
}

.board, .grid {
    -webkit-tap-highlight-color: transparent;
    -webkit-touch-callout: none;
    -webkit-appearance: none;
    outline: none;
    border: none;
    touch-action: manipulation;
}

/* 移动端专用优化 */
@media (hover: none) and (pointer: coarse) {
    .btn {
        transform: none !important;
    }
    
    .board-content {
        touch-action: pan-x pan-y pinch-zoom !important;
    }
}
```

## 7. 插件安装

### 7.1 必需插件

```bash
# 白名单插件（安全）
cordova plugin add cordova-plugin-whitelist

# 启动画面插件
cordova plugin add cordova-plugin-splashscreen

# 状态栏插件
cordova plugin add cordova-plugin-statusbar

# 设备信息插件（可选）
cordova plugin add cordova-plugin-device

# 网络信息插件（可选）
cordova plugin add cordova-plugin-network-information
```

### 7.2 验证插件安装

```bash
cordova plugin list
```

## 8. 构建和打包

### 8.1 调试版本构建

```bash
# 构建调试版本
cordova build android

# 运行到设备（需要连接Android设备或启动模拟器）
cordova run android
```

### 8.2 发布版本构建

```bash
# 构建发布版本
cordova build android --release

# 生成的APK位置
# platforms/android/app/build/outputs/apk/release/app-release-unsigned.apk
```

### 8.3 APK签名

```bash
# 1. 生成密钥库（首次）
keytool -genkey -v -keystore wuziqi-release-key.keystore -alias wuziqi -keyalg RSA -keysize 2048 -validity 10000

# 2. 签名APK
jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore wuziqi-release-key.keystore platforms/android/app/build/outputs/apk/release/app-release-unsigned.apk wuziqi

# 3. 对齐APK
zipalign -v 4 platforms/android/app/build/outputs/apk/release/app-release-unsigned.apk wuziqi-game-v1.0.0.apk
```

## 9. 测试和验证

### 9.1 功能测试清单

- [ ] 应用正常启动
- [ ] 游戏界面正确显示
- [ ] 触摸落子功能正常
- [ ] 拖拽和缩放功能正常
- [ ] 技能系统正常工作
- [ ] 普通模式AI对战正常
- [ ] 游戏规则和胜负判断正确
- [ ] 移动端触摸优化生效
- [ ] 应用图标和名称正确
- [ ] 启动画面正常显示

### 9.2 性能测试

- [ ] 应用启动速度
- [ ] 游戏响应速度
- [ ] 内存使用情况
- [ ] 电池消耗情况

## 10. 发布准备

### 10.1 应用商店准备

1. **应用描述**：
   - 应用名称：五子棋游戏
   - 简短描述：技能五子棋，支持普通模式和技能模式
   - 详细描述：包含游戏特色、玩法说明等

2. **截图准备**：
   - 准备不同屏幕尺寸的应用截图
   - 展示主要游戏界面和功能

3. **隐私政策**：
   - 如果应用收集用户数据，需要准备隐私政策

### 10.2 版本管理

```bash
# 更新版本号
# 修改config.xml中的version属性
# 修改package.json中的version属性

# 重新构建
cordova clean android
cordova build android --release
```

## 11. 故障排除

### 11.1 常见问题

1. **构建失败**：
   - 检查Android SDK配置
   - 确认Gradle版本兼容性
   - 清理项目：`cordova clean android`

2. **触摸功能异常**：
   - 确认移动端CSS优化已应用
   - 检查cordova.js是否正确加载
   - 验证设备就绪事件处理

3. **性能问题**：
   - 优化图片资源大小
   - 减少DOM操作频率
   - 使用硬件加速

### 11.2 调试方法

```bash
# 启用远程调试
cordova run android --debug

# 查看日志
adb logcat | grep "CordovaActivity"
```

## 12. 自动化构建脚本

创建 `build-apk.bat`（Windows）或 `build-apk.sh`（Linux/Mac）：

```bash
@echo off
echo 开始构建五子棋Android应用...

echo 1. 清理项目
cordova clean android

echo 2. 复制最新游戏文件
copy ..\index.html www\
copy ..\styles.css www\

echo 3. 构建发布版本
cordova build android --release

echo 4. 检查构建结果
if exist "platforms\android\app\build\outputs\apk\release\app-release-unsigned.apk" (
    echo 构建成功！APK文件位置：
    echo platforms\android\app\build\outputs\apk\release\app-release-unsigned.apk
) else (
    echo 构建失败，请检查错误信息
)

pause
```

## 13. 总结

通过以上步骤，你可以成功将五子棋Web应用打包为Android APK文件。关键要点：

1. **保持现有功能**：确保拖拽、缩放、触摸优化在移动应用中正常工作
2. **移动端优化**：添加必要的移动端CSS和JavaScript优化
3. **资源准备**：准备合适尺寸的图标和启动画面
4. **测试验证**：在真实设备上充分测试所有功能
5. **版本管理**：建立良好的版本控制和发布流程

完成打包后，你将获得一个可以在Android设备上安装运行的五子棋游戏应用。