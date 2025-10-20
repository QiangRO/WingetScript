##########################################################################################################
#                                    ADMINISTRADOR PERMISSIONS REQUIRED                                  #
#                                                                                                        #
#  This script will write the following functions to your Powershell Profile:                            #
#                                                                                                        #
#     * UpdateAll.                                                                                      #
#     * UpdateGeneral.                                                                          #
#     * UpdateDevelopment                                                                       #
#     * UpdateBrowser.                                                                                 #
#     * UpdateGame.                                                                                    #
#     * UpdateSocial.                                                                           #
#     * UpdateConsole.                                                                          #
#                                                                                                        #
##########################################################################################################
$functionContentUpdate = @'
##########################################################################################################
#                                             UPDATE SCRIPTS                                             #
##########################################################################################################

function UpdateGeneral {
    Write-Host "Actualizando General Programas" -ForegroundColor Cyan
    $generalPrograms = Get-ProgramJson -category "generalPrograms"
    foreach ($programa in $generalPrograms) {
        Write-Host "Actualizando $programa." -ForegroundColor DarkBlue
        winget upgrade -e --id $programa
    }
}

function UpdateDevelopment {
    Write-Host "Actualizando programas Development" -ForegroundColor Cyan

    $developmentPrograms = Get-ProgramJson -category "developmentPrograms"

    foreach ($programa in $developmentPrograms) {
        Write-Host "Actualizando $programa." -ForegroundColor DarkBlue
        winget upgrade -e --id $programa
    }
}

function UpdateBrowser {
    Write-Host "Actualizando programas Browser" -ForegroundColor Cyan

    $browserPrograms = Get-ProgramJson -category "browserPrograms"

    foreach ($programa in $browserPrograms) {
        Write-Host "Actualizando $programa." -ForegroundColor DarkBlue
        winget upgrade -e --id $programa
    }
}

function UpdateGame {
    Write-Host "Actualizando programas Gaming" -ForegroundColor Cyan

    $gamingPrograms = Get-ProgramJson -category "gamingPrograms"

    foreach ($programa in $gamingPrograms) {
        Write-Host "Actualizando $programa." -ForegroundColor DarkBlue
        winget upgrade -e --id $programa
    }
}

function UpdateSocial {
    Write-Host "Actualizando programas Social Network" -ForegroundColor Cyan

    $socialNetworkPrograms = Get-ProgramJson -category "socialNetworkPrograms"

    foreach ($programa in $socialNetworkPrograms) {
        Write-Host "Actualizando $programa." -ForegroundColor DarkBlue
        winget upgrade -e --id $programa
    }
}

function UpdateConsole {
    Write-Host "Actualizando programas Console" -ForegroundColor Cyan
    
    $consolePrograms = Get-ProgramJson -category "consolePrograms"

    foreach ($programa in $consolePrograms) {
        Write-Host "Actualizando $programa." -ForegroundColor DarkBlue
        winget upgrade -e --id $programa
    }
}

function UpdateAll {
    Write-Host "Actualizando todos los programas instalados." -ForegroundColor Cyan
    UpdateGeneral
    UpdateDevelopment
    UpdateBrowser
    UpdateGame
    UpdateSocial
    UpdateConsole
}
'@

$profilePath = $PROFILE

$profileDir = [System.IO.Path]::GetDirectoryName($profilePath)
if (-not(Test-Path -Path $profileDir)) {
    Write-Host "El archivo de perfil no existe, se procedera a crearlo"
    New-Item -ItemType File -Path $PROFILE -Force
}else {
    Write-Host "El archivo de perfil ya existe"
}

Add-Content -Path $profilePath -Value "`r`n$functionContentUpdate`r`n"

Write-Host "Las funciones de Actualizacion fueron agregadas al perfil de PowerShell de manera exitosa." -ForegroundColor Green