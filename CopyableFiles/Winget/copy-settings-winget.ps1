$scriptPath = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent

$sourcePath = Join-Path -Path $scriptPath -ChildPath "settings.json"
$destinationPath = Join-Path $env:LOCALAPPDATA "Packages\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe\LocalState"
Copy-Item -Path $sourcePath -Destination $destinationPath -Force
Write-Host "Arhivo $sourcePath copiado en $destinationPath" -ForegroundColor Green
