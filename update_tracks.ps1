# update_tracks.ps1
# Run this whenever you add or remove MP3s from the music/gameplay/ folder
# It renames all MP3s to track1.mp3, track2.mp3, etc. for the game to find

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$gameplayDir = Join-Path $scriptDir "music\gameplay"

# Create folder if it doesn't exist
if (-not (Test-Path $gameplayDir)) {
    New-Item -ItemType Directory -Path $gameplayDir -Force | Out-Null
    Write-Host "Created music/gameplay/ folder - drop your MP3s in there!" -ForegroundColor Yellow
}

# Get all MP3s that AREN'T already named trackN.mp3
$allMp3s = Get-ChildItem -Path $gameplayDir -Filter "*.mp3" | Sort-Object Name
$existingTracks = $allMp3s | Where-Object { $_.Name -match '^track\d+\.mp3$' }
$newFiles = $allMp3s | Where-Object { $_.Name -notmatch '^track\d+\.mp3$' }

# Find the highest existing track number
$maxNum = 0
foreach ($t in $existingTracks) {
    if ($t.Name -match '^track(\d+)\.mp3$') {
        $num = [int]$Matches[1]
        if ($num -gt $maxNum) { $maxNum = $num }
    }
}

# Rename new files
$count = 0
foreach ($f in $newFiles) {
    $maxNum++
    $newName = "track$maxNum.mp3"
    Rename-Item -Path $f.FullName -NewName $newName
    Write-Host "  Renamed: $($f.Name) -> $newName" -ForegroundColor Yellow
    $count++
}

# Final count
$finalTracks = Get-ChildItem -Path $gameplayDir -Filter "track*.mp3" | Sort-Object Name

Write-Host ""
Write-Host "=== Game Room Party - Track Updater ===" -ForegroundColor Cyan
Write-Host ""
if ($count -gt 0) {
    Write-Host "Renamed $count new files" -ForegroundColor Yellow
}
Write-Host "Total gameplay tracks: $($finalTracks.Count)" -ForegroundColor Green
foreach ($t in $finalTracks) {
    Write-Host "  $($t.Name)" -ForegroundColor White
}
Write-Host ""
Write-Host "Done! The game will auto-detect these on startup." -ForegroundColor Green
Write-Host "Press any key to exit..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
