##########################################################################################################
#                                    ADMINISTRADOR PERMISSIONS REQUIRED                                  #
#                                           ORCHESTRATOR SCRIPT                                          #
##########################################################################################################
#                                                                                                        #
#  This script serves as a primary orchestrator within the WingetScript automation system. Its main      #
# purpose is to coordinate the sequential and modular execution of child scripts for installation,       #
# configuration, and file operations, ensuring a ready-to-use development environment.                   #
#                                                                                                        #
#     * Start-ThirdScript                                                                                #
#     * Start-ScriptInstall                                                                              #
#     * Start-ScriptInstall                                                                              #
#     * Start-ScriptDownload                                                                             #
#     * Start-ScriptDelete                                                                               #
#     * Start-ScriptUpdate                                                                               #
#     * Start-ScriptAdd                                                                                  #
#     * Start-ScriptShow                                                                                 #
#     * Start-CopyJSONPrograms                                                                           #
#     * Start-PSProfile                                                                                  #
#     * Test-Functions                                                                            #
#     * Profile-Function                                                                                 #
#     * Main.                                                                                            #
#                                                                                                        #
##########################################################################################################

param(
    [string[]]$FunctionNames,
    [switch]$ChainExecution
)
#Rutas
$scriptPath = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
$Third = Join-Path -Path $scriptPath -ChildPath "3.Script-Copyfiles.ps1"

$profilePath = $PROFILE
$profileDir = [System.IO.Path]::GetDirectoryName($profilePath)

function Start-ThirdScript{
    # Start-Process pwsh -Verb RunAs -ArgumentList "-NoExit", "-ExecutionPolicy Bypass", "-Command", "& { . '$Third' -FunctionNames 'Copyfiles-Function' }"

    $command = ". '$Third' -FunctionNames 'Copyfiles-Function'"
    if ($ChainExecution) {
        $command += " -ChainExecution"
    }
    $processArgs = @(
        "-NoExit",
        "-ExecutionPolicy", "Bypass",
        "-Command", "& { $command }"
    )
    Start-Process pwsh -Verb RunAs -ArgumentList $processArgs
}

function Start-CopyJSONPrograms {
    Write-Host "Copiando el script con los ID'S de programas..." -ForegroundColor DarkBlue
    $scriptIDPath = Join-Path -Path $scriptPath -ChildPath "ProgramasId.json"
    Write-Host "profileDir $profileDir" -ForegroundColor Yellow
    Write-Host "scriptIDPath $scriptIDPath" -ForegroundColor Yellow
    Copy-Item -Path $scriptIDPath -Destination $profileDir -Recurse -Force
    Write-Host "El archivo que contiene los ID'S de Programas fue copiado en: $profileDir" -ForegroundColor Green
}

Function Add-OhmyposhlineToProfile{
    $mythemePath = Join-Path $env:LOCALAPPDATA "$env:POSH_THEMES_PATH\my-theme.omp.json"
    $ohmyposhInit = "oh-my-posh init pwsh --config '$mythemePath' | Invoke-Expression"

    $profileContent = Get-Content -Path $profilePath -Raw
    $lineExists = $false
    foreach ($line in $profileContent) {
        if ($line.Trim() -eq $ohmyposhInit) {
            $lineExists = $true
            break
        }
    }
    if (-not $lineExists) {
        Add-Content -Path $profilePath -Value "`r`n$ohmyposhInit`r`n"
        Write-Host "Inicialización de OhMyPosh añadida al perfil de PowerShell." -ForegroundColor Green
    }else {
        Write-Host "Inicialización de OhMyPosh ya existe en el perfil de PowerShell." -ForegroundColor Green
    }
}

function Start-ScriptInstall {
    $wingetInstallScriptPath = Join-Path -Path $scriptPath -ChildPath "ScriptWinget\1.script-install.ps1"
    Write-Host "Inicializando el script de Winget Install: $wingetInstallScriptPath" -ForegroundColor Cyan
    & $wingetInstallScriptPath
}

function Start-ScriptDownload {
    $wingetDownloadScriptPath = Join-Path -Path $scriptPath -ChildPath "ScriptWinget\2.script-download.ps1"
    Write-Host "Inicializando el script de Winget Download: $wingetDownloadScriptPath" -ForegroundColor Cyan
    & $wingetDownloadScriptPath
}

function Start-ScriptDelete {
    $wingetDeleteScriptPath = Join-Path -Path $scriptPath -ChildPath "ScriptWinget\3.script-delete.ps1"
    Write-Host "Inicializando el script de Winget Delete: $wingetDeleteScriptPath" -ForegroundColor Cyan
    & $wingetDeleteScriptPath
}

function Start-ScriptUpdate {
    $wingetUpdateScriptPath = Join-Path -Path $scriptPath -ChildPath "ScriptWinget\4.script-update.ps1"
    Write-Host "Inicializando el script de Winget Update: $wingetUpdateScriptPath" -ForegroundColor Cyan
    & $wingetUpdateScriptPath
}

function Start-ScriptId {
    $wingetAddScriptPath = Join-Path -Path $scriptPath -ChildPath "ScriptWinget\5.script-id.ps1"
    Write-Host "Inicializando el script de Winget Agregar: $wingetAddScriptPath" -ForegroundColor Cyan
    & $wingetAddScriptPath
}

function Start-ScriptUtility {
    $wingetShowScriptPath = Join-Path -Path $scriptPath -ChildPath "ScriptWinget\6.script-utility.ps1"
    Write-Host "Inicializando el script de Winget Mostrar: $wingetShowScriptPath" -ForegroundColor Cyan
    & $wingetShowScriptPath
}

function Start-ScriptShow {
    $wingetShowScriptPath = Join-Path -Path $scriptPath -ChildPath "ScriptWinget\7.script-show.ps1"
    Write-Host "Inicializando el script de Winget Mostrar: $wingetShowScriptPath" -ForegroundColor Cyan
    & $wingetShowScriptPath
}

function Start-PSProfile {
    if (-not(Test-Path -Path $profileDir)) {
        New-Item -ItemType Directory -Path $profileDir -Force
    }
}

function Test-Functions {
    foreach ($FunctionName in $FunctionNames) {
        if (Get-Command -Name $FunctionName -ErrorAction SilentlyContinue) {
            & $FunctionName
        } else {
            Write-Host "La función '$FunctionName' no existe." -ForegroundColor Red
        }
    }
}

function Profile-Function {
    Write-Host "Ejecutando segundo script"
    Write-Host "Creando el perfil de Powershell 7" -ForegroundColor Cyan
    Start-PSProfile
    Write-Host "Agregando OhMyPosh al perfil de Powershell 7" -ForegroundColor Cyan
    Add-OhmyposhlineToProfile
    Write-Host "Escribiendo funciones en el perfil Powershell 7"
    Start-ScriptInstall
    Start-ScriptDownload
    Start-ScriptDelete
    Start-ScriptUpdate
    Start-ScriptId
    Start-ScriptUtility
    Start-ScriptShow
    Start-CopyJSONPrograms
    Write-Host "Todas las funciones han sido escritas en el perfil" -ForegroundColor Green
    if ($ChainExecution.IsPresent) {
        Write-Host "Llamando al tercer script"
        Start-ThirdScript
    }else {
        Write-Host "Script '2.Script-Profile.ps1''fue ejecutado correctamente"    
    }
}

function Main {

}

if ($FunctionNames) {
    Test-Functions
}else {
    Main
}