##########################################################################################################
#                                    ADMINISTRADOR PERMISSIONS REQUIRED                                  #
#                                                                                                        #
#  This script will write the following functions to your Powershell Profile:                            #
#                                                                                                        #
#     * UninstallAll.                                                                                   #
#     * UninstallGeneral.                                                                       #
#     * UninstallDevelopment                                                                    #
#     * UninstallBrowser.                                                                              #
#     * UninstallGame.                                                                                 #
#     * UninstallSocial.                                                                        #
#     * UninstallConsole.                                                                       #
#                                                                                                        #
##########################################################################################################
$functionContentDelete = @'
##########################################################################################################
#                                             DELETE SCRIPTS                                             #
##########################################################################################################

function UninstallGeneral {
    $generalPrograms = Get-ProgramJson -category "generalPrograms"
    Write-Host "Desinstalando Programas" -ForegroundColor Cyan
    foreach ($programa in $generalPrograms) {
        Write-Host "Desinstalando $programa." -ForegroundColor DarkBlue
        winget uninstall $programs
    }
}

function UninstallDevelopment {
    Write-Host "Desinstalando programas Development" -ForegroundColor Cyan

    $developmentPrograms = Get-ProgramJson -category "developmentPrograms"

    foreach ($programa in $developmentPrograms) {
        Write-Host "Desinstalando $programa." -ForegroundColor DarkBlue
        winget uninstall $developmentPrograms
    }
}

function UninstallBrowser {
    Write-Host "Desinstalando programas Browser" -ForegroundColor Cyan

    $browserPrograms = Get-ProgramJson -category "browserPrograms"

    foreach ($programa in $browserPrograms) {
        Write-Host "Desinstalando $programa." -ForegroundColor DarkBlue
        winget uninstall $browserPrograms
    }
}

function UninstallGame {
    Write-Host "Desinstalando programas Gaming" -ForegroundColor Cyan

    $gamingPrograms = Get-ProgramJson -category "gamingPrograms"

    foreach ($programa in $gamingPrograms) {
        Write-Host "Desinstalando $programa." -ForegroundColor DarkBlue
        winget uninstall $gamingPrograms
    }
}

function UninstallSocial {
    Write-Host "Desinstalando programas Social Network" -ForegroundColor Cyan

    $socialNetworkPrograms =  Get-ProgramJson -category "socialNetworkPrograms"

    foreach ($programa in $socialNetworkPrograms) {
        Write-Host "Desinstalando $programa." -ForegroundColor DarkBlue
        winget uninstall $socialNetworkPrograms
    }
}

function UninstallConsole {
    Write-Host "Desinstalando programas Console" -ForegroundColor Cyan

    $consolePrograms = Get-ProgramJson -category "consolePrograms"

    foreach ($programa in $consolePrograms) {
        Write-Host "Desinstalando $programa." -ForegroundColor DarkBlue
        winget uninstall $consolePrograms
    }
}

function UninstallAll {
    Write-Host "Desinstalando todos los programas de la lista." -ForegroundColor DarkBlue
    UninstallGeneral
    UninstallDevelopment
    UninstallBrowser
    UninstallGame
    UninstallSocial
    UninstallConsole
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

Add-Content -Path $profilePath -Value "`r`n$functionContentDelete`r`n"

Write-Host "Las funciones de Eliminacion fueron agregadas al perfil de PowerShell de manera exitosa." -ForegroundColor Green