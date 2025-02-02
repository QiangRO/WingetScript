##########################################################################################################
#                                    ADMINISTRADOR PERMISSIONS REQUIRED                                  #
#                                                                                                        #
#  This script will write the following functions to your Powershell Profile:                            #
#                                                                                                        #
#     * Uninstall-All.                                                                                   #
#     * Uninstall-Programs.                                                                              #
#     * Uninstall-DevelopmentPrograms                                                                    #
#     * Uninstall-Browsers.                                                                              #
#     * Uninstall-Games.                                                                                 #
#     * Uninstall-SocialNetworks.                                                                        #
#     * Uninstall-ConsolePrograms.                                                                       #
#                                                                                                        #
##########################################################################################################
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
$functionContentDelete = @'
##########################################################################################################
#                                             DELETE SCRIPTS                                             #
##########################################################################################################

function Uninstall-Programs {
    $programs = Get-ProgramJson -category "programs"
    Write-Host "Desinstalando Programas" -ForegroundColor Cyan
    foreach ($programa in $programs) {
        Write-Host "Desinstalando $programa." -ForegroundColor DarkBlue
        winget uninstall $programs
    }
}

function Uninstall-DevelopmentPrograms {
    Write-Host "Desinstalando programas Development" -ForegroundColor Cyan

    $developmentPrograms = Get-ProgramJson -category "developmentPrograms"

    foreach ($programa in $developmentPrograms) {
        Write-Host "Desinstalando $programa." -ForegroundColor DarkBlue
        winget uninstall $developmentPrograms
    }
}

function Uninstall-Browsers {
    Write-Host "Desinstalando programas Browser" -ForegroundColor Cyan

    $browserPrograms = Get-ProgramJson -category "browserPrograms"

    foreach ($programa in $browserPrograms) {
        Write-Host "Desinstalando $programa." -ForegroundColor DarkBlue
        winget uninstall $browserPrograms
    }
}

function Uninstall-Games {
    Write-Host "Desinstalando programas Gaming" -ForegroundColor Cyan

    $gamingPrograms = Get-ProgramJson -category "gamingPrograms"

    foreach ($programa in $gamingPrograms) {
        Write-Host "Desinstalando $programa." -ForegroundColor DarkBlue
        winget uninstall $gamingPrograms
    }
}

function Uninstall-SocialNetworks {
    Write-Host "Desinstalando programas Social Network" -ForegroundColor Cyan

    $socialNetworkPrograms =  Get-ProgramJson -category "socialNetworkPrograms"

    foreach ($programa in $socialNetworkPrograms) {
        Write-Host "Desinstalando $programa." -ForegroundColor DarkBlue
        winget uninstall $socialNetworkPrograms
    }
}

function Uninstall-ConsolePrograms {
    Write-Host "Desinstalando programas Console" -ForegroundColor Cyan

    $consolePrograms = Get-ProgramJson -category "consolePrograms"

    foreach ($programa in $consolePrograms) {
        Write-Host "Desinstalando $programa." -ForegroundColor DarkBlue
        winget uninstall $consolePrograms
    }
}

function Uninstall-All {
    Write-Host "Desinstalando todos los programas de la lista." -ForegroundColor DarkBlue
    Uninstall-Programs
    Uninstall-DevelopmentPrograms
    Uninstall-Browsers
    Uninstall-Games
    Uninstall-SocialNetworks
    Uninstall-ConsolePrograms
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