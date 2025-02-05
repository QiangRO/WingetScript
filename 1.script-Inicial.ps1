Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope CurrentUser

Write-Host "Instalando configuracion Inicial" -ForegroundColor DarkBlue

#Instalacion de programas iniciales
winget upgrade -e --id Microsoft.AppInstaller

winget install -e --id JanDeDobbeleer.OhMyPosh -s winget

winget install -e --id Microsoft.PowerShell

winget install -e --id Microsoft.WindowsTerminal

winget settings