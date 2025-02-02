Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass

New-Item -ItemType File -Path $PROFILE -Force

$scriptWingetPath = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent

function Start-ScriptInstall {
    $wingetInstallScriptPath = Join-Path -Path $scriptWingetPath -ChildPath "ScriptWinget\1.1.script-install.ps1"
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



Write-Host "Inicializando todos los scripts de Winget"
Start-ScriptInstall
Start-ScriptDownload
Start-ScriptDelete
Start-ScriptUpdate
Start-ScriptAdd
Start-ScriptShow
Write-Host "Los scripts han sido iniciados"

#Copiado de ID'S de programas
Write-Host "Copiando el script con los ID'S de programas..." -ForegroundColor DarkBlue
$scriptIDPath = Join-Path -Path $scriptWingetPath -ChildPath "ProgramasId.ps1"

$profilePath = $PROFILE
$profileDir = [System.IO.Path]::GetDirectoryName($profilePath) #Obtiene el directorio de una ruta
if (-not(Test-Path -Path $profileDir)) {
    New-Item -ItemType Directory -Path $profileDir -Force
}
Copy-Item -Path $scriptIDPath -Destination $profileDir -Recurse -Force
Write-Host "El archivo que contiene los ID'S de Programas fue copiado en: $profileDir" -ForegroundColor Green
