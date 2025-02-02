##########################################################################################################
#                                    ADMINISTRADOR PERMISSIONS REQUIRED                                  #
#                                                                                                        #
#  This script will write the following functions to your Powershell Profile:                            #
#                                                                                                        #
#     * Update-All.                                                                                      #
#     * Update-Programs.                                                                                 #
#     * Update-DevelopmentPrograms                                                                       #
#     * Update-Browsers.                                                                                 #
#     * Update-Games.                                                                                    #
#     * Update-SocialNetworks.                                                                           #
#     * Update-ConsolePrograms.                                                                          #
#                                                                                                        #
##########################################################################################################
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
$functionContentUpdate = @'

##########################################################################################################
#                                             UPDATE SCRIPTS                                             #
##########################################################################################################

function Update-Programs {
    Write-Host "Actualizando Programas" -ForegroundColor Cyan
    $programs = Get-ProgramJson -category "programs"
    foreach ($programa in $programs) {
        Write-Host "Actualizando $programa." -ForegroundColor DarkBlue
        winget update $programs
    }
}

function Update-DevelopmentPrograms {
    Write-Host "Actualizando programas Development" -ForegroundColor Cyan

    $developmentPrograms = Get-ProgramJson -category "developmentPrograms"

    foreach ($programa in $developmentPrograms) {
        Write-Host "Actualizando $programa." -ForegroundColor DarkBlue
        winget update $developmentPrograms
    }
}

function Update-Browsers {
    Write-Host "Actualizando programas Browser" -ForegroundColor Cyan

    $browserPrograms = Get-ProgramJson -category "browserPrograms"

    foreach ($programa in $browserPrograms) {
        Write-Host "Actualizando $programa." -ForegroundColor DarkBlue
        winget update $browserPrograms
    }
}

function Update-Games {
    Write-Host "Actualizando programas Gaming" -ForegroundColor Cyan

    $gamingPrograms = Get-ProgramJson -category "gamingPrograms"

    foreach ($programa in $gamingPrograms) {
        Write-Host "Actualizando $programa." -ForegroundColor DarkBlue
        winget update $gamingPrograms
    }
}

function Update-SocialNetworks {
    Write-Host "Actualizando programas Social Network" -ForegroundColor Cyan

    $socialNetworkPrograms = Get-ProgramJson -category "socialNetworkPrograms"

    foreach ($programa in $socialNetworkPrograms) {
        Write-Host "Actualizando $programa." -ForegroundColor DarkBlue
        winget update $socialNetworkPrograms
    }
}

function Update-ConsolePrograms {
    Write-Host "Actualizando programas Console" -ForegroundColor Cyan
    
    $consolePrograms = Get-ProgramJson -category "consolePrograms"

    foreach ($programa in $consolePrograms) {
        Write-Host "Actualizando $programa." -ForegroundColor DarkBlue
        winget update $consolePrograms
    }
}

function Update-All {
    Write-Host "Actualizando todos los programas instalados." -ForegroundColor Cyan
    winget upgrade --all
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