$scriptPath = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent

$sourcePath = Join-Path -Path $scriptPath -ChildPath "my-theme.omp.json"
$sourcePath2 = Join-Path -Path $scriptPath -ChildPath "my-theme-ram.omp.json"
$destinationPath = Join-Path $env:LOCALAPPDATA "Programs\oh-my-posh\themes"

Copy-Item -Path $sourcePath -Destination $destinationPath -Force
Copy-Item -Path $sourcePath2 -Destination $destinationPath -Force
Write-Host "Arhivo $sourcePath copiado en $destinationPath" -ForegroundColor Green
