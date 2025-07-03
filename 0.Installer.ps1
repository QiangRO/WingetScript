##########################################################################################################
#                                    ADMINISTRADOR PERMISSIONS REQUIRED                                  #
#                                           ORCHESTRATOR SCRIPT                                          #
##########################################################################################################
#                                                                                                        #
#  This script serves as a primary orchestrator within the WingetScript automation system. Its main      #
# purpose is to coordinate the sequential and modular execution of child scripts for installation,       #
# configuration, and file operations, ensuring a ready-to-use development environment.                   #
#                                                                                                        #
##########################################################################################################

Write-Host "Descargando el repositorio WingetScript." -ForegroundColor Cyan

$tempZip = "$env:TEMP\WingetScript.zip"
$tempFolder = "$env:TEMP\WingetScript-main"

$script1 = Join-Path $tempFolder "1.Inicializer-File.ps1"
$script2 = Join-Path $tempFolder "2.Script-Profile.ps1"
$script3 = Join-Path $tempFolder "3.Script-Copyfiles.ps1"


#PRUEBAS
# $scriptPath = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent

#ENFOQUES
#Solo ejecuta una funcion
# Start-Process powershell.exe -Verb RunAs -ArgumentList "-ExecutionPolicy Bypass -File `"$scriptToRun`" -FunctionNames Write-Message"

#Ejecuta N cantidad de funciones
# Start-Process pwsh -Verb RunAs -ArgumentList "-NoExit", "-ExecutionPolicy Bypass", "-Command", "& { . '$Second' -FunctionNames 'Main' }" 


Invoke-WebRequest -Uri "https://github.com/QiangRO/WingetScript/archive/refs/heads/main.zip" -OutFile $tempZip

Expand-Archive -Path $tempZip -DestinationPath $env:TEMP -Force

Set-Location -Path $tempFolder

Write-Host "`n¿Qué deseas ejecutar?" -ForegroundColor Cyan
Write-Host "1. Inicializador"
Write-Host "2. Script de perfil"
Write-Host "3. Copiar archivos"
Write-Host "4. Ejecutar todo"
$choice = Read-Host "Ingresa una opción [1-4]"


switch ($choice) {
    "1" {
        Write-Host "Ejecutando el orquestador 1.Inicializer-File.ps1 como administrador." -ForegroundColor Cyan
        
        Start-Process powershell.exe -Verb RunAs -ArgumentList "-NoExit", "-ExecutionPolicy Bypass", "-Command", "& { . '$script1' -FunctionNames 'Inicializer-Function'}"
    }
    "2" {
        Write-Host "Ejecutando el orquestador 2.Script-Profile.ps1 como administrador." -ForegroundColor Cyan

        Start-Process pwsh -Verb RunAs -ArgumentList "-NoExit", "-ExecutionPolicy Bypass", "-Command", "& { . '$script2' -FunctionNames 'Profile-Function' }"
    }
    "3" {
        Write-Host "Ejecutando el orquestador 3.Script-Copyfiles.ps1 como administrador." -ForegroundColor Cyan
        
        Start-Process pwsh -Verb RunAs -ArgumentList "-NoExit", "-ExecutionPolicy Bypass", "-Command", "& { . '$script3' -FunctionNames 'Copyfiles-Function' }"
    }
    "4" {
        Start-Process powershell.exe -Verb RunAs -ArgumentList "-NoExit", "-ExecutionPolicy Bypass", "-Command", "& { . '$script1' -FunctionNames 'Inicializer-Function' -ChainExecution}"
    }
    default {
        Write-Host "Opción no válida" -ForegroundColor Red
    }
}