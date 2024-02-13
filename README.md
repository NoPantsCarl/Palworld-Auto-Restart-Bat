# Palworld-Restart-Bat

A bat file designed to automatically restart the server, sends Discord webhooks message, checks for updates, broadcasts warnings, saves data, restarts on crash, auto-backups every 4 hours, and creates backups before restarting.

## Description

This bat file performs the following tasks:
- Checks for updates.
- Launches the server.
- Sends a Discord webhook message indicating that the server is online after 2 minutes and at the 5 min warning.
- Initiates in-game broadcasts for a restart warning and a 1-minute warning, as well as saving data, after 8 hours.
- Performs backup of save files after shutting down the server, then loops back to checking for updates.
- Checks if the server has crashed and restarts.
- Backs up every 4 hours.

### Setting up Bat

1. Place the startup batch file (`start_server.bat`) in the same directory as your `PalServer-Win64-Test-Cmd.exe`. For example, if your `PalServer-Win64-Test-Cmd.exe` is located at `\PalServer\Pal\Binaries\Win64`, place the batch file there.

2. Place `ARRCON.exe` in the same location as the batch file.

3. **Line 6:** Update the file path in the batch file to point to your `steamcmd.exe`. This ensures proper server updates.

4. **Line 16:** Adjust the duration of the server restart by changing the timeout value (in seconds). For instance, for an 8-hour restart, set it to `timeout /t 28800`.

5. **Customize the messages sent to Discord with the lines that start with curl. Modify "Server One Is Online" and "Server One 5 Min Restart Warning" to suit your preferences.

6. **Your Discord Webhook URL:** Replace the placeholder with your actual Discord webhook URL.

7. **IP address 192.0.0.1, 25575 RCON port, and admin password to match your server configuration.

8. **Line 14:** Optionally, adjust the timeout duration after server boot. The default is 120 seconds, allowing time for the server to initialize before players join.

9. **Line 76, 102:** Set the path to your save game directory.

10. **Line 77, 103:** Specify the directory where you want your backups to be stored.

11. **Line 83:** Define a backup location in case of errors with the original backup directory.

Feel free to reach out if you need further assistance! As I will probably update this guide to be more clear in the future!

#### Requirements
1. [ARRCON](https://github.com/radj307/ARRCON)
2. [7-Zip](https://www.7-zip.org/)
3. Running Windows and not Linux.

#### Note
If you don't want to use Discord webhooks, you can remove line 14 and all the other lines that start with curl.
