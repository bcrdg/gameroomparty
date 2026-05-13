@echo off
REM Find and run the update_tracks ps1 script in same folder
for %%f in ("%~dp0update_tracks*.ps1") do (
    powershell -ExecutionPolicy Bypass -File "%%f"
    goto :done
)
echo Could not find update_tracks.ps1
pause
:done
