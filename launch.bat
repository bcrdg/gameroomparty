@echo off
set "FILE=C:\gameroomparty\gameroomparty.html"
set "URL=file:///%FILE:\=/%"

start "" msedge --kiosk "%URL%" --edge-kiosk-type=fullscreen