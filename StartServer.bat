@echo off

:start

echo Checking for updates...
C:\PalWorldDedicatedServer\Server01\steamcmd.exe +login anonymous +app_update 2394010 +quit
if errorlevel 1 (
    echo Error: Checking for updates failed.
    goto :start
)

echo Launching server one...
start PalServer-Win64-Test-Cmd.exe EpicApp=PalServer -useperfthreads -NoAsyncLoadingThread -UseMultithreadForDS
timeout /t 120 /nobreak > NUL 2>&1
curl -i -H "Accept: application/json" -H "Content-Type:application/json" -X POST --data "{\"content\": \"**```fix\nServer One Is Online```**\"}"Your Discord Webhook Url > NUL 2>&1
timeout /t 28200 /nobreak > NUL 2>&1
if errorlevel 1 (
    echo Error: Launching server failed.
    goto :start
)


:saving

curl -i -H "Accept: application/json" -H "Content-Type:application/json" -X POST --data "{\"content\": \"**\`​``diff\n- Server One 5 Min Restart Warning\`​``**\"}"Your Discord Webhook Url > NUL 2>&1
echo Broadcast 5 Min Warning...
start ARRCON.exe -H 192.0.0.1 -P 25575 -p "Admin Password" "Broadcast ServerRestartIn5min."
timeout /t 240 /nobreak > NUL 2>&1
if errorlevel 1 (
    echo Error: Broadcasting 5 min warning failed.
    goto :saving
)

echo Saving...
start ARRCON.exe -H 192.0.0.1 -P 25575 -p "Admin Password" "save"
timeout /t 5 /nobreak > NUL 2>&1
if errorlevel 1 (
    echo Error: Saving failed.
    goto :saving
)

echo Broadcasting shutdown warning...
start ARRCON.exe -H 192.0.0.1 -P 25575 -p "Admin Password" "shutdown 60 ServerRestartIn1minLOGOUTNOW."
timeout /t 80 /nobreak > NUL 2>&1
if errorlevel 1 (
    echo Error: Broadcasting shutdown warning failed.
    goto :saving
)

:backup

echo Backing Up...
set SOURCE_DIR="C:\PalWorldDedicatedServer\Server01\steamapps\common\PalServer\Pal\Saved\SaveGames\"
set BACKUP_DIR="C:\Users\Administrator\Desktop\Vanilla_BackUp"
set DATE=%date:~-4,4%%date:~-10,2%%date:~-7,2%_%time:~0,2%%time:~3,2%%time:~6,2%

"C:\Program Files\7-Zip\7z.exe" a -tzip "%BACKUP_DIR%\backup_%DATE%.zip" %SOURCE_DIR%
if errorlevel 1 (
    echo Primary backup failed. Attempting secondary backup...
    set SECONDARY_BACKUP_DIR="D:\Backup"
    if not exist "%SECONDARY_BACKUP_DIR%" mkdir "%SECONDARY_BACKUP_DIR%"
    "C:\Program Files\7-Zip\7z.exe" a -tzip "%SECONDARY_BACKUP_DIR%\backup_%DATE%.zip" %SOURCE_DIR%
    if errorlevel 1 (
        echo Error: Secondary backup failed as well.
    ) else (
        echo Backup of %SOURCE_DIR% completed at %SECONDARY_BACKUP_DIR%\backup_%DATE%.zip
    )
) else (
    echo Backup of %SOURCE_DIR% completed at %BACKUP_DIR%\backup_%DATE%.zip
)

timeout /t 300 /nobreak > NUL 2>&1

goto start