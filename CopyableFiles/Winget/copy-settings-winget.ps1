Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass

$scriptPath = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent

$sourcePath = Join-Path -Path $scriptPath -ChildPath "settings.json"
$destinationPath = "C:\Users\aroch\AppData\Local\Packages\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe\LocalState"

Copy-Item -Path $sourcePath -Destination $destinationPath -Force
Write-Host "Arhivo $sourcePath copiado en $destinationPath" -ForegroundColor Green
