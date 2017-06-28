@echo off

:: https://the.earth.li/~sgtatham/putty/latest/w64/putty.exe

putty -t -ssh SSH_USER@REMOTE_IP -pw SSH_PASS -m GitSwitcher.sh

pause
