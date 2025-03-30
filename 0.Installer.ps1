# Mostrar progreso
Write-Host "Descargando el repositorio WingetScript..." -ForegroundColor Cyan

# Ruta temporal
$tempZip = "$env:TEMP\WingetScript.zip"
$tempFolder = "$env:TEMP\WingetScript-main"

# Descargar el .zip
Invoke-WebRequest -Uri "https://github.com/QiangRO/WingetScript/archive/refs/heads/main.zip" -OutFile $tempZip

# Extraer
Expand-Archive -Path $tempZip -DestinationPath $env:TEMP -Force

# Entrar a la carpeta del repositorio
Set-Location -Path $tempFolder

# Ejecutar el orquestador como administrador, con política de ejecución Bypass
$scriptToRun = Join-Path -Path $tempFolder -ChildPath "1.Inicializer-File.ps1"
Write-Host "Ejecutando el orquestador 1.Inicializer-File.ps1 como administrador..." -ForegroundColor Cyan
Start-Process powershell.exe -Verb RunAs -ArgumentList "-NoExit -ExecutionPolicy Bypass -File `"$scriptToRun`""

#Start-Process powershell.exe -Verb RunAs -ArgumentList "-NoExit -ExecutionPolicy Bypass -File `"$script`""
