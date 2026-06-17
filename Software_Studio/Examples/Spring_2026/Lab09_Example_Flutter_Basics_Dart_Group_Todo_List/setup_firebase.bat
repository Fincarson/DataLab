@echo off
chcp 65001 >nul

echo === 1. Cleaning up broken firebase-tools ===
call npm uninstall -g firebase-tools
call npm cache clean --force
powershell -Command "Remove-Item -Recurse -Force '$env:APPDATA\npm\node_modules\firebase-tools' -ErrorAction SilentlyContinue"

echo === 2. Force reinstalling firebase-tools ===
call npm install -g firebase-tools --force

echo === 3. Run Firebase Login ===
echo Please complete login in your browser. After login, return to this window.
call firebase login

echo === 4. Start installing flutterfire_cli ===
call dart pub global activate flutterfire_cli

echo === 5. Add path to User Environment Variable ===
powershell -Command "[Environment]::SetEnvironmentVariable('Path', [Environment]::GetEnvironmentVariable('Path', 'User') + ';%LOCALAPPDATA%\Pub\Cache\bin', 'User')"

echo === 6. Run flutterfire configure ===
"%LOCALAPPDATA%\Pub\Cache\bin\flutterfire.exe" configure

echo === All steps completed successfully! ===
pause
