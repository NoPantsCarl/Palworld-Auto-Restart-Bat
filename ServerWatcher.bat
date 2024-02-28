@echo off

REM Define the process name
set "PROCESS_NAME=PalServer-Win64-Test-Cmd.exe"

:check_server

REM Check if the process is running
set "RUNNING="
for /f %%a in ('wmic process where "name='%PROCESS_NAME%'" get name 2^>nul ^| find /i "%PROCESS_NAME%"') do set "RUNNING=%%a"

REM Start the server if the process is not running
if not defined RUNNING (
    echo [%TIME%] %PROCESS_NAME% is not running. Starting server...
    cd /d "C:\SteamServers\steamapps\common\PalServer\Pal\Binaries\Win64"
    start StartServer.bat
) else (
    echo [%TIME%] %PROCESS_NAME% is already running.
)

REM Wait for 5 minutes before checking again
timeout /t 300 /nobreak >NUL

REM Check server status again after waiting
goto :check_server





























