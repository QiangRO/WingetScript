#PRUEBAS
# $scriptPath = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent

#ENFOQUES
#Solo ejecuta una funcion
# Start-Process powershell.exe -Verb RunAs -ArgumentList "-ExecutionPolicy Bypass -File `"$scriptToRun`" -FunctionNames Write-Message"

#Ejecuta n cantidad de funciones
# Start-Process pwsh -Verb RunAs -ArgumentList "-NoExit", "-ExecutionPolicy Bypass", "-Command", "& { . '$Second' -FunctionNames 'Main' }" 

Write-Host "Descargando el repositorio WingetScript..." -ForegroundColor Cyan

$tempZip = "$env:TEMP\WingetScript.zip"
$tempFolder = "$env:TEMP\WingetScript-main"

Invoke-WebRequest -Uri "https://github.com/QiangRO/WingetScript/archive/refs/heads/main.zip" -OutFile $tempZip

Expand-Archive -Path $tempZip -DestinationPath $env:TEMP -Force

Set-Location -Path $tempFolder

$scriptToRun = Join-Path -Path $tempFolder -ChildPath "1.Inicializer-File.ps1"
Write-Host "Ejecutando el orquestador 1.Inicializer-File.ps1 como administrador." -ForegroundColor Cyan
Start-Process powershell.exe -Verb RunAs -ArgumentList "-NoExit", "-ExecutionPolicy Bypass", "-Command", "& { . '$scriptToRun' -FunctionNames 'Inicializer-Function'}"
