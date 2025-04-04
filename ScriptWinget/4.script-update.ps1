##########################################################################################################
#                                    ADMINISTRADOR PERMISSIONS REQUIRED                                  #
#                                                                                                        #
#  This script will write the following functions to your Powershell Profile:                            #
#                                                                                                        #
#     * Update-All.                                                                                      #
#     * Update-GeneralPrograms.                                                                          #
#     * Update-DevelopmentPrograms                                                                       #
#     * Update-Browsers.                                                                                 #
#     * Update-Games.                                                                                    #
#     * Update-SocialNetworks.                                                                           #
#     * Update-ConsolePrograms.                                                                          #
#                                                                                                        #
##########################################################################################################
$functionContentUpdate = 

##########################################################################################################
#                                             UPDATE SCRIPTS                                             #
##########################################################################################################

function Update-GeneralPrograms {
    Write-Host "Actualizando General Programas" -ForegroundColor Cyan
    $generalPrograms = Get-ProgramJson -category "generalPrograms"
    foreach ($programa in $generalPrograms) {
        Write-Host "Actualizando $programa." -ForegroundColor DarkBlue
        winget upgrade -e --id $programa
    }
}

function Update-DevelopmentPrograms {
    Write-Host "Actualizando programas Development" -ForegroundColor Cyan

    $developmentPrograms = Get-ProgramJson -category "developmentPrograms"

    foreach ($programa in $developmentPrograms) {
        Write-Host "Actualizando $programa." -ForegroundColor DarkBlue
        winget upgrade -e --id $programa
    }
}

function Update-Browsers {
    Write-Host "Actualizando programas Browser" -ForegroundColor Cyan

    $browserPrograms = Get-ProgramJson -category "browserPrograms"

    foreach ($programa in $browserPrograms) {
        Write-Host "Actualizando $programa." -ForegroundColor DarkBlue
        winget upgrade -e --id $programa
    }
}

function Update-Games {
    Write-Host "Actualizando programas Gaming" -ForegroundColor Cyan

    $gamingPrograms = Get-ProgramJson -category "gamingPrograms"

    foreach ($programa in $gamingPrograms) {
        Write-Host "Actualizando $programa." -ForegroundColor DarkBlue
        winget upgrade -e --id $programa
    }
}

function Update-SocialNetworks {
    Write-Host "Actualizando programas Social Network" -ForegroundColor Cyan

    $socialNetworkPrograms = Get-ProgramJson -category "socialNetworkPrograms"

    foreach ($programa in $socialNetworkPrograms) {
        Write-Host "Actualizando $programa." -ForegroundColor DarkBlue
        winget upgrade -e --id $programa
    }
}

function Update-ConsolePrograms {
    Write-Host "Actualizando programas Console" -ForegroundColor Cyan
    
    $consolePrograms = Get-ProgramJson -category "consolePrograms"

    foreach ($programa in $consolePrograms) {
        Write-Host "Actualizando $programa." -ForegroundColor DarkBlue
        winget upgrade -e --id $programa
    }
}

function Update-All {
    Write-Host "Actualizando todos los programas instalados." -ForegroundColor Cyan
    Update-GeneralPrograms
    Update-DevelopmentPrograms
    Update-Browsers
    Update-Games
    Update-SocialNetworks
    Update-ConsolePrograms
}


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