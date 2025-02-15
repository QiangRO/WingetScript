##########################################################################################################
#                                    ADMINISTRADOR PERMISSIONS REQUIRED                                  #
#                                                                                                        #
#  File that will initialize the scripts and create new powershell instances.                            #
#                                                                                                        #
#     * Start-ScriptInstall                                                                              #
#     * Start-ScriptDownload                                                                             #
#     * Start-ScriptDelete                                                                               #
#     * Start-ScriptUpdate                                                                               #
#     * Start-ScriptAdd                                                                                  #
#     * Start-ScriptShow                                                                                 #
#     * Start-CopyJSONPrograms                                                                           #
#     * Create-ProfilePowershell                                                                         #
#     * TestExecute-Functions                                                                            #
#     * Start-ThirdScript                                                                                #
#     * Main.                                                                                            #
#                                                                                                        #
##########################################################################################################

param(
    [string[]]$FunctionNames
)
#Rutas
$scriptWingetPath = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
$First = Join-Path -Path $scriptPath -ChildPath "1.Inicializer-File.ps1"
$Second = Join-Path -Path $scriptPath -ChildPath "2.Script-Profile.ps1"
$Third = Join-Path -Path $scriptPath -ChildPath "3.Script-Copyfiles.ps1"

Write-Host "Ejecutando el segundo script" -ForegroundColor Cyan
function Write-Message {
    Write-Host "Ejecutando el segundo script" -ForegroundColor Cyan
}

function Start-ScriptInstall {
    $wingetInstallScriptPath = Join-Path -Path $scriptWingetPath -ChildPath "ScriptWinget\1.script-install.ps1"
    Write-Host "Inicializando el script de Winget Install: $wingetInstallScriptPath" -ForegroundColor Cyan
    & $wingetInstallScriptPath
}

function Start-ScriptDownload {
    $wingetDownloadScriptPath = Join-Path -Path $scriptWingetPath -ChildPath "ScriptWinget\2.script-download.ps1"
    Write-Host "Inicializando el script de Winget Download: $wingetDownloadScriptPath" -ForegroundColor Cyan
    & $wingetDownloadScriptPath
}

function Start-ScriptDelete {
    $wingetDeleteScriptPath = Join-Path -Path $scriptWingetPath -ChildPath "ScriptWinget\3.script-delete.ps1"
    Write-Host "Inicializando el script de Winget Delete: $wingetDeleteScriptPath" -ForegroundColor Cyan
    & $wingetDeleteScriptPath
}

function Start-ScriptUpdate {
    $wingetUpdateScriptPath = Join-Path -Path $scriptWingetPath -ChildPath "ScriptWinget\4.script-update.ps1"
    Write-Host "Inicializando el script de Winget Update: $wingetUpdateScriptPath" -ForegroundColor Cyan
    & $wingetUpdateScriptPath
}

function Start-ScriptAdd {
    $wingetAddScriptPath = Join-Path -Path $scriptWingetPath -ChildPath "ScriptWinget\5.script-add.ps1"
    Write-Host "Inicializando el script de Winget Agregar: $wingetAddScriptPath" -ForegroundColor Cyan
    & $wingetAddScriptPath
}

function Start-ScriptShow {
    $wingetShowScriptPath = Join-Path -Path $scriptWingetPath -ChildPath "ScriptWinget\6.script-show.ps1"
    Write-Host "Inicializando el script de Winget Mostrar: $wingetShowScriptPath" -ForegroundColor Cyan
    & $wingetShowScriptPath
}

function Start-CopyJSONPrograms {
    Write-Host "Copiando el script con los ID'S de programas..." -ForegroundColor DarkBlue
    $scriptIDPath = Join-Path -Path $scriptWingetPath -ChildPath "ProgramasId.json"
    Copy-Item -Path $scriptIDPath -Destination $profileDir -Recurse -Force
    Write-Host "El archivo que contiene los ID'S de Programas fue copiado en: $profileDir" -ForegroundColor Green
}

function Create-ProfilePowershell {
    $profilePath = $PROFILE
    $profileDir = [System.IO.Path]::GetDirectoryName($profilePath) #Obtiene el directorio de una ruta
    if (-not(Test-Path -Path $profileDir)) {
        New-Item -ItemType Directory -Path $profileDir -Force
    }
}

function TestExecute-Functions {
    foreach ($FunctionName in $FunctionNames) {
        if (Get-Command -Name $FunctionName -ErrorAction SilentlyContinue) {
            $FunctionName
        }else {
            Write-Host "La función '$FunctionName' no existe." -ForegroundColor Red
        }
    }
}

function Start-ThirdScript {
    Start-Process pwsh -ArgumentList "-NoExit", "-Command", "& { . '$Third' -FunctionNames ''}"
}

function Main {
    Start-Process pwsh -ArgumentList "-NoExit", "-Command", "& { . '$Second' -FunctionNames 'Write-Message'}"
}

if ($FunctionNames) {
    TestExecute-Functions
}else {
    Main
}

# Write-Host "Inicializando todos los scripts de Winget"
# Start-ScriptInstall
# Start-ScriptDownload
# Start-ScriptDelete
# Start-ScriptUpdate
# Start-ScriptAdd
# Start-ScriptShow
# Write-Host "Los scripts han sido iniciados"