@echo off
REM ThreeCraft Installer
Title ThreeCraft Installer
    for /F %%a in ('echo prompt $E ^| cmd') do set "ESC=%%a"

REM https://cdn.jsdelivr.net/gh/ThreeCraft/ThreeCraftServer/server.js will be installed

REM Select installation directory
set /p installDir=Enter installation directory (default: %cd%\ThreeCraftServer):
if "%installDir%"=="" set installDir=%cd%\ThreeCraftServer
mkdir "%installDir%"
cd /d "%installDir%"    
echo.
echo %ESC%[93m Installing ThreeCraft Server to %installDir% %ESC%[0m
echo.
REM Download server.js
echo %ESC%[92m Downloading server.js... %ESC%[0m
powershell -Command "Invoke-WebRequest -Uri 'https://cdn.jsdelivr.net/gh/ThreeCraft/ThreeCraftServer/server.js' -OutFile 'server.js'"
echo.
REM Create package.json
echo %ESC%[92m Downloading package.json... %ESC%[0m
powershell -Command "Invoke-WebRequest -Uri 'https://cdn.jsdelivr.net/gh/ThreeCraft/ThreeCraftServer/package.json' -OutFile 'package.json'"
echo.
REM Start npm install
echo %ESC%[92m Installing dependencies... %ESC%[0m
npm install
echo.
echo %ESC%[92m Installation complete! %ESC%[0m
echo Starting Server...
echo.
call node server.js
