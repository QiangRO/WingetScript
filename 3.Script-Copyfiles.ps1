##########################################################################################################
#                                    ADMINISTRADOR PERMISSIONS REQUIRED                                  #
#                                           ORCHESTRATOR SCRIPT                                          #
##########################################################################################################
#                                                                                                        #
#  This script serves as a primary orchestrator within the WingetScript automation system. Its main      #
# purpose is to coordinate the sequential and modular execution of child scripts for installation,       #
# configuration, and file operations, ensuring a ready-to-use development environment.                   #
#                                                                                                        #
#     * Start-InstallFonts                                                                               #
#     * Start-CopyOhMyPosh                                                                               #
#     * Start-CopyTerminalSettings                                                                       #
#     * Start-CopyWingetSettings                                                                         #
#     * TestExecute-Functions                                                                            #
#     * Copyfiles-Function                                                                               #
#     * Main.                                                                                            #
#                                                                                                        #
##########################################################################################################

param(
    [string[]]$FunctionNames,
    [switch]$ChainExecution
)

#Rutas
$scriptPath = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent

function Start-InstallFonts {
    $fontScriptPath = Join-Path -Path $scriptPath -ChildPath "Fonts\install-fonts.ps1"
    Write-Host "Inicializando el script de instalación de fuentes: $fontScriptPath" -ForegroundColor Cyan
    & $fontScriptPath
}

# function Start-CopyKeepass {
#     $keepassScriptPath = Join-Path -Path $scriptPath -ChildPath "CopyableFiles\Keepass\copy-plugins-database.ps1"
#     Write-Host "Inicializando el script de Keepass: $keepassScriptPath" -ForegroundColor Cyan
#     & $keepassScriptPath
# }

function Start-CopyOhMyPosh {
    $ohMyPoshScriptPath = Join-Path -Path $scriptPath -ChildPath "CopyableFiles\OhMyPosh\copy-theme-settings.ps1"
    Write-Host "Inicializando el script de configuración de OhMyPosh: $ohMyPoshScriptPath" -ForegroundColor Cyan
    & $ohMyPoshScriptPath
}

function Start-CopyTerminalSettings {
    $terminalScriptPath = Join-Path -Path $scriptPath -ChildPath "CopyableFiles\Terminal\copy-terminal-settings.ps1"
    Write-Host "Inicializando el script de configuración de Windows Terminal: $terminalScriptPath" -ForegroundColor Cyan
    & $terminalScriptPath
}

function Start-CopyWingetSettings {
    $wingetScriptPath = Join-Path -Path $scriptPath -ChildPath "CopyableFiles\Winget\copy-settings-winget.ps1"
    Write-Host "Inicializando el script de configuración de Winget: $wingetScriptPath" -ForegroundColor Cyan
    & $wingetScriptPath
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

function Copyfiles-Function {
    Write-Host "Ejecutando el tercer script" -ForegroundColor Cyan
    Write-Host "Inicializando todos los scripts de copiado de archivos" -ForegroundColor DarkBlue
    Start-InstallFonts
    Start-CopyOhMyPosh
    Start-CopyTerminalSettings
    Start-CopyWingetSettings
    Write-Host "Script '3.Script-Copyfiles.ps1''fue ejecutado correctamente" -ForegroundColor Green
}

function Main {
    
}

if ($FunctionNames) {
    TestExecute-Functions
}else {
    Main
}