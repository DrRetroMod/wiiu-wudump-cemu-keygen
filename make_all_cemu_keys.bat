@echo off
setlocal

cd /d "%~dp0"

echo Running Wii U Cemu key generator...
echo Root folder: %CD%
echo.

powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0make_all_cemu_keys.ps1"

echo.
echo Finished running script.
echo.
pause
endlocal