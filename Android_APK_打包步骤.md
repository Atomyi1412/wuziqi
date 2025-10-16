# Android APK 打包步骤（Cordova）

> 本文档基于当前项目环境（Windows），包含快速打包与发布版签名流程。适用于目录 `e:/trae/wuziqi/mobile-app`。

## 前置条件
- 已安装 Node.js（本机为 `v22`）
- 已安装 Cordova CLI（本机为 `12.x`）
- 已安装 JDK 17（Android Gradle Plugin 需要 Java 17）
- 已安装 Android SDK（默认路径：`C:\Users\<用户名>\AppData\Local\Android\Sdk`）

## 快速打包（调试版 APK）
1. 打开 PowerShell，切到移动端项目目录：
   ```powershell
   cd e:\trae\wuziqi\mobile-app
   ```
2. 可选：安装依赖（如第一次构建或依赖变更）：
   ```powershell
   npm ci --no-fund --no-audit
   ```
3. 设置临时环境变量（当前会话）：
   ```powershell
   $env:JAVA_HOME = 'C:\Program Files\Eclipse Adoptium\jdk-17.0.16.8-hotspot'
   $sdk = Join-Path $env:LOCALAPPDATA 'Android\Sdk'
   $env:ANDROID_HOME = $sdk
   $env:ANDROID_SDK_ROOT = $sdk
   $env:PATH = "$env:JAVA_HOME\bin;$env:PATH;$sdk\platform-tools;$sdk\tools"
   javac -version
   ```
4. 构建调试版 APK：
   ```powershell
   cordova build android --debug
   ```
5. 输出位置：
   - `e:\trae\wuziqi\mobile-app\platforms\android\app\build\outputs\apk\debug\app-debug.apk`

## 安装到真机测试
- 方式一：将 APK 拷贝到手机直接安装（需允许安装未知来源）
- 方式二：ADB 安装（需开启 USB 调试）：
  ```powershell
  adb install -r "e:\trae\wuziqi\mobile-app\platforms\android\app\build\outputs\apk\debug\app-debug.apk"
  ```

## 发布版打包与签名（可选）
1. 生成发布版 APK：
   ```powershell
   cordova build android --release
   ```
   输出路径：`platforms/android/app/build/outputs/apk/release/app-release.apk`
2. 使用 `apksigner` 签名（示例）：
   ```powershell
   apksigner sign ^
     --ks C:\path\to\your.keystore ^
     --ks-key-alias your_alias ^
     --out app-release-signed.apk ^
     platforms\android\app\build\outputs\apk\release\app-release.apk
   ```
3. 可选：对齐优化（旧流程）：
   ```powershell
   zipalign -v -p 4 app-release-signed.apk app-release-aligned.apk
   ```

## 常见问题排查
- 提示需要 Java 17：
  - 确认 `JAVA_HOME` 指向 JDK 17，并将 `JAVA_HOME\bin` 置于 `PATH` 前部。
- SDK 未找到：
  - 设置 `ANDROID_HOME`/`ANDROID_SDK_ROOT` 到 `C:\Users\<用户名>\AppData\Local\Android\Sdk`。
- Gradle 不可用：
  - 安装 Gradle 或使用 Android Studio；Cordova 会使用项目自带的 Gradle Wrapper。
- 构建成功但浏览器预览报 `cordova.js` 404：
  - 这是浏览器环境下的正常现象，不影响 APK 内运行。

## 目录结构参考
```
mobile-app/
  www/                # 前端资源
  platforms/android/  # Android 平台构建产物
  plugins/            # Cordova 插件
  config.xml          # Cordova 配置
  build.bat           # 一键构建脚本
```

---
如需统一应用名称、版本号、图标或签名信息，请告知，我将调整 `config.xml` 与相关资源后再打包。