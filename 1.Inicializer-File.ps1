##########################################################################################################
#                                    ADMINISTRADOR PERMISSIONS REQUIRED                                  #
#                                                                                                        #
#  File that will initialize the scripts and create new powershell instances.                            #
#                                                                                                        #
#     * TestExecute-Functions.                                                                           #
#     * Main.                                                                                            #
#     * Initial-Function                                                                                 #
#     * Start-SecondScript                                                                               #
#                                                                                                        #
##########################################################################################################

param (
    [string[]]$FunctionNames
)

#Rutas
$scriptPath = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
$Second = Join-Path -Path $scriptPath -ChildPath "2.Script-Profile.ps1"

function Write-Message {
    Write-Host "Ejecutando el primer script, llamando al segundo script" -ForegroundColor Cyan
}

function TestExecute-Functions {
    foreach ($FunctionName in $FunctionNames) {
        if (Get-Command -Name $FunctionName -ErrorAction SilentlyContinue) {
            & $FunctionName
        } else {
            Write-Host "La función '$FunctionName' no existe." -ForegroundColor Red
        }
    }
}

function Install-FirstPrograms{
    Write-Host "Actualizando App Installer" -ForegroundColor Cyan
    winget upgrade -e --id Microsoft.AppInstaller

    Write-Host "Instalando Windows Terminal" -ForegroundColor Cyan
    winget install -e --id Microsoft.WindowsTerminal

    #Write-Host "Instalando Powershell 7" -ForegroundColor Cyan
    #winget install -e --id Microsoft.PowerShell

    #Write-Host "Aplicando configuraciones Winget" -ForegroundColor Cyan
    #winget settings

    #Write-Host "Instalando OhMyPosh 7" -ForegroundColor Cyan
    #winget install -e --id JanDeDobbeleer.OhMyPosh -s winget
}

function Wait-ForPwsh {
    Write-Host "Esperando a que PowerShell 7 esté disponible." -ForegroundColor Yellow
    while (-not (Get-Command pwsh -ErrorAction SilentlyContinue)) {
        Start-Sleep -Seconds 2
    }
    Write-Host "PowerShell 7 está listo." -ForegroundColor Green
}


function Main {
    Install-FirstPrograms
    Wait-ForPwsh
    Write-Host "Llamando al segundo script" -ForegroundColor Cyan
    #Start-Process pwsh -ArgumentList "-NoExit", "-Command", "& { . '$Second' -FunctionNames 'Start-AllProfileFunctions' }"
    Start-Process pwsh -ArgumentList "-NoExit", "-ExecutionPolicy Bypass", "-Command", "& { . '$Second' -FunctionNames 'Start-AllProfileFunctions' }" -Verb RunAs
}
  
if ($FunctionNames) {
    TestExecute-Functions
} else {
    Main
}
