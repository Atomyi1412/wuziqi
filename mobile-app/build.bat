@echo off
echo ========================================
echo 五子棋游戏 Android APK 构建脚本
echo ========================================

echo.
echo 检查环境...
node --version
if %errorlevel% neq 0 (
    echo 错误: Node.js 未安装或未正确配置
    pause
    exit /b 1
)

cordova --version
if %errorlevel% neq 0 (
    echo 错误: Cordova 未安装或未正确配置
    pause
    exit /b 1
)

echo.
echo 环境检查完成！

echo.
echo 选择构建选项:
echo 1. 构建浏览器版本 (用于测试)
echo 2. 构建Android调试版APK (需要Android SDK)
echo 3. 运行浏览器版本
echo 4. 退出
echo.

set /p choice=请输入选项 (1-4): 

if "%choice%"=="1" goto build_browser
if "%choice%"=="2" goto build_android
if "%choice%"=="3" goto run_browser
if "%choice%"=="4" goto exit
goto invalid_choice

:build_browser
echo.
echo 构建浏览器版本...
cordova build browser
if %errorlevel% equ 0 (
    echo 构建成功！
    echo 文件位置: platforms\browser\www\
) else (
    echo 构建失败！
)
pause
goto menu

:build_android
echo.
echo 检查Android SDK...
if "%ANDROID_HOME%"=="" (
    echo 警告: ANDROID_HOME 环境变量未设置
    echo 请确保已安装Android SDK并设置环境变量
    echo.
    echo 设置方法:
    echo 1. 下载并安装Android Studio
    echo 2. 设置ANDROID_HOME环境变量指向SDK目录
    echo 3. 将SDK的tools和platform-tools目录添加到PATH
    echo.
    set /p continue=是否继续尝试构建? (y/n): 
    if /i not "%continue%"=="y" goto menu
)

echo.
echo 构建Android调试版APK...
cordova build android --debug
if %errorlevel% equ 0 (
    echo 构建成功！
    echo APK文件位置: platforms\android\app\build\outputs\apk\debug\
    dir platforms\android\app\build\outputs\apk\debug\*.apk
) else (
    echo 构建失败！请检查Android SDK配置
)
pause
goto menu

:run_browser
echo.
echo 启动浏览器版本...
echo 服务器将在 http://localhost:8000 启动
echo 按 Ctrl+C 停止服务器
cordova serve browser
goto menu

:invalid_choice
echo 无效选项，请重新选择
pause

:menu
cls
goto start

:exit
echo 退出构建脚本
exit /b 0

:start
goto menu