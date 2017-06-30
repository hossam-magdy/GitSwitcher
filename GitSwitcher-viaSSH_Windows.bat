@ECHO OFF

SET ssh_ip=REMOTE_IP
SET ssh_user=SSH_USER
SET ssh_pass=SSH_PASS
SET commands_file=%~dp0\GitSwitcher.sh

SET DOWNLOAD_FROM=https://the.earth.li/~sgtatham/putty/latest/w64/putty.exe
WHERE putty >NUL 2>&1
IF %ERRORLEVEL% NEQ 0 (
    powershell -command "curl -outf \"%~dp0\putty.exe\" \"%DOWNLOAD_FROM%\""
)

putty -t -ssh %ssh_user%@%ssh_ip% -pw %ssh_pass% -m "%commands_file%"

PAUSE
