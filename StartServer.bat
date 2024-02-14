@echo off

:update_check
echo [%TIME%] Checking for updates...
C:\SteamServers\steamapps\common\PalServer\steamcmd.exe +login anonymous +app_update 2394010 +quit
if errorlevel 1 (
    echo [%TIME%] Error: Checking for updates failed.
    goto :update_check
)

:start_server
echo [%TIME%] Launching server...
start "" "C:\SteamServers\steamapps\common\PalServer\Pal\Binaries\Win64\PalServer-Win64-Test-Cmd.exe" EpicApp=PalServer -useperfthreads -NoAsyncLoadingThread -UseMultithreadForDS
timeout /t 120 /nobreak > NUL 2>&1
curl -i -H "Accept: application/json" -H "Content-Type:application/json" -X POST --data "{\"content\": \"**```fix\nServer One Is Online```**\"}" Your Discord Webhook Url > NUL 2>&1
echo [%TIME%] PalServer-Win64-Test-Cmd.exe is running.

timeout /t 14100 /nobreak > NUL 2>&1

:4hour_backup
echo [%TIME%] Initiating Four Hour Backup...
start ARRCON.exe -H 192.0.0.1 -P 25577 -p "Admin Password" "save"
set SOURCE_DIR="C:\SteamServers\steamapps\common\PalServer\Pal\Pal\Saved\SaveGames\"
set BACKUP_DIR="C:\Users\NoPantsCarl\Documents\PalWorld_BackUps"
set DATE=%date:~-4,4%%date:~-10,2%%date:~-7,2%_%time:~0,2%%time:~3,2%%time:~6,2%

"C:\Program Files\7-Zip\7z.exe" a -tzip "%BACKUP_DIR%\backup_%DATE%.zip" %SOURCE_DIR%
if errorlevel 1 (
    echo [%TIME%] Four Hour Backup failed.
) else (
    echo [%TIME%] Four Hour Backup completed at %BACKUP_DIR%\backup_%DATE%.zip
)

timeout /t 14400 /nobreak > NUL 2>&1

:broadcasting_5min
curl -i -H "Accept: application/json" -H "Content-Type:application/json" -X POST --data "{\"content\": \"**```fix\nServer One 5 Min Warning```**\"}" Your Discord Webhook Url > NUL 2>&1
echo [%TIME%] Broadcast 5 Min Warning...
start ARRCON.exe -H 192.0.0.1 -P 25575 -p "Admin Password" "Broadcast ServerRestartIn5min."
timeout /t 120 /nobreak > NUL 2>&1
if errorlevel 1 (
    echo [%TIME%] Error: Broadcasting 5 min warning failed.
    goto :broadcasting_5min
)

:broadcasting_3min
echo [%TIME%] Broadcast 3 Min Warning...
start ARRCON.exe -H 192.0.0.1 -P 25575 -p "Admin Password" "Broadcast ServerRestartIn3min."
timeout /t 60 /nobreak > NUL 2>&1
if errorlevel 1 (
    echo [%TIME%] Error: Broadcasting 3 min warning failed.
    goto :broadcasting_3min
)

:broadcasting_2min
echo [%TIME%] Broadcast 2 Min Warning...
start ARRCON.exe -H 192.0.0.1 -P 25575 -p "Admin Password" "Broadcast ServerRestartIn2min."
timeout /t 60 /nobreak > NUL 2>&1
if errorlevel 1 (
    echo [%TIME%] Error: Broadcasting 2 min warning failed.
    goto :broadcasting_2min
)

:saving
echo [%TIME%] Saving...
start ARRCON.exe -H 192.0.0.1 -P 25575 -p "Admin Password" "save"
timeout /t 5 /nobreak > NUL 2>&1
if errorlevel 1 (
    echo [%TIME%] Error: Saving failed.
    goto :saving
)

:shutdown_1min
echo [%TIME%] Broadcasting shutdown warning...
start ARRCON.exe -H 192.0.0.1 -P 25575 -p "Admin Password" "shutdown 60 ServerRestartIn1minLOGOUTNOW."
timeout /t 80 /nobreak > NUL 2>&1
if errorlevel 1 (
    echo [%TIME%] Error: Broadcasting shutdown warning failed.
    goto :shutdown_1min
)

:backup
echo [%TIME%] Backing Up...
set SOURCE_DIR="C:\SteamServers\steamapps\common\PalServer\Pal\Saved\SaveGames\"
set BACKUP_DIR="C:\Users\NoPantsCarl\Documents\PalWorld_BackUps"
set DATE=%date:~-4,4%%date:~-10,2%%date:~-7,2%_%time:~0,2%%time:~3,2%%time:~6,2%

"C:\Program Files\7-Zip\7z.exe" a -tzip "%BACKUP_DIR%\backup_%DATE%.zip" %SOURCE_DIR%
if errorlevel 1 (
    echo [%TIME%] Primary backup failed. Attempting secondary backup...
    set SECONDARY_BACKUP_DIR="D:\PalWorld_BackUps"
    if not exist "%SECONDARY_BACKUP_DIR%" mkdir "%SECONDARY_BACKUP_DIR%"
    "C:\Program Files\7-Zip\7z.exe" a -tzip "%SECONDARY_BACKUP_DIR%\backup_%DATE%.zip" %SOURCE_DIR%
    if errorlevel 1 (
        echo [%TIME%] Error: Secondary backup failed as well.
    ) else (
        echo [%TIME%] Backup of %SOURCE_DIR% completed at %SECONDARY_BACKUP_DIR%\backup_%DATE%.zip
    )
) else (
    echo [%TIME%] Backup of %SOURCE_DIR% completed at %BACKUP_DIR%\backup_%DATE%.zip
)

timeout /t 300 /nobreak > NUL 2>&1

goto update_check
