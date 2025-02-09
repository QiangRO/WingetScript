##########################################################################################################
#                                    ADMINISTRADOR PERMISSIONS REQUIRED                                  #
#                                                                                                        #
#  This script will write the following functions to your Powershell Profile:                            #
#                                                                                                        #
#     * Save-All.                                                                                        #
#     * Save-Programs.                                                                                   #
#     * Save-DevelopmentPrograms                                                                         #
#     * Save-Browsers.                                                                                   #
#     * Save-Games.                                                                                      #
#     * Save-SocialNetworks.                                                                             #
#     * Save-ConsolePrograms.                                                                            #
#                                                                                                        #
##########################################################################################################
$functionContentDownload = @'
##########################################################################################################
#                                            DOWNLOAD SCRIPTS                                            #
##########################################################################################################
function Save-Programs {
    Write-Host "Descargando Programs" -ForegroundColor Cyan

    $programs = Get-ProgramJson -category "programs"

    foreach ($programa in $programs) {
        $pathProgram = "$downloadsPath\Programs\$programa"
        if (-not(Test-Path $pathProgram)) {
            Write-Host "Descargando $programa." -ForegroundColor DarkBlue
            winget download -e --id $programa -d $pathProgram
        }
        else {
            Write-Host "El directorio $pathProgram ya existe. El programa ya fue descargado." -ForegroundColor Green
        }
    }
}

function Save-DevelopmentPrograms {
    Write-Host "Descargando programas Development " -ForegroundColor Cyan

    $developmentPrograms = Get-ProgramJson -category "developmentPrograms"

    foreach ($programa in $developmentPrograms) {
        $pathDevelopmentProgram = "$downloadsPath\Development\$programa"
        if (-not (Test-Path $pathDevelopmentProgram)) {
            Write-Host "Descargando $programa." -ForegroundColor DarkBlue
            winget download -e --id $programa -d $pathDevelopmentProgram
        }
        else {
            Write-Host "El directorio $pathDevelopmentProgram ya existe. El programa ya fue descargado." -ForegroundColor Green
        }
        
    }
}

function Save-Browsers {
    Write-Host "Descargando programas Browser" -ForegroundColor Cyan

    $browserPrograms = Get-ProgramJson -category "browserPrograms"

    foreach ($programa in $browserPrograms) {
        $pathBrowserProgram = "$downloadsPath\Browsers\$programa"
        if (-not (Test-Path $pathBrowserProgram)) {
            Write-Host "Descargando $programa." -ForegroundColor DarkBlue
            winget download -e --id $programa -d $pathBrowserProgram
        }
        else {
            Write-Host "El directorio $pathBrowserProgram ya existe. El programa ya fue descargado." -ForegroundColor Green
        }
    }
}

function Save-Games {
    Write-Host "Descargando programas Gaming" -ForegroundColor Cyan

    $gamingPrograms = Get-ProgramJson -category "gamingPrograms"

    foreach ($programa in $gamingPrograms) {
        $pathGamingProgram = "$downloadsPath\Gaming\$programa"
        if (-not (Test-Path $pathGamingProgram)) {
            Write-Host "Descargando $programa." -ForegroundColor DarkBlue
            winget download -e --id $programa -d $pathGamingProgram
        }
        else {
            Write-Host "El directorio $pathGamingProgram ya existe. El programa ya fue descargado." -ForegroundColor Green
        }
    }
}

function Save-SocialNetworks {
    Write-Host "Descargando programas Social Network" -ForegroundColor Cyan

    $socialNetworkPrograms = Get-ProgramJson -category "socialNetworkPrograms"

    foreach ($programa in $socialNetworkPrograms) {
        $pathSocialProgram = "$downloadsPath\SocialNetworks\$programa"
        if (-not (Test-Path $pathSocialProgram)) {
            Write-Host "Descargando $programa." -ForegroundColor DarkBlue
            winget download -e --id $programa -d $pathSocialProgram
        }
        else {
            Write-Host "El directorio $pathSocialProgram ya existe. El programa ya fue descargado." -ForegroundColor Green
        }
    }
}

function Save-ConsolePrograms {
    Write-Host "Descargando programas Console" -ForegroundColor Cyan

    $consolePrograms = Get-ProgramJson -category "consolePrograms"

    foreach ($programa in $consolePrograms) {
        $pathConsoleProgram = "$downloadsPath\Console\$programa"
        switch ($programa) {
            "Terminal-Icons" {
                if (-not (Test-Path $pathConsoleProgram)) {
                    New-Item -Path $pathConsoleProgram -ItemType Directory | Out-Null
                    Write-Host "Directorio $pathConsoleProgram creado." -ForegroundColor Green
                    Save-Module -Name $programa -Repository PSGallery -Path "$pathConsoleProgram"
                }
                else {
                    Write-Host "El directorio $pathConsoleProgram ya existe. El programa ya fue descargado." -ForegroundColor Green
                }
            }
            Default {
                if (-not(Test-Path $pathConsoleProgram)) {
                    Write-Host "Descargando $programa." -ForegroundColor DarkBlue
                    winget download -e --id $programa -d $pathConsoleProgram
                }
                else {
                    Write-Host "El directorio $pathConsoleProgram ya existe. El programa ya fue descargado." -ForegroundColor Green
                }
            }
        }
    }
}

function Save-All {
    Write-Host "Descargando todos los programas de la lista." -ForegroundColor Cyan
    Save-Programs
    Save-DevelopmentPrograms
    Save-Browsers
    Save-Games
    Save-SocialNetworks
    Save-ConsolePrograms
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

Add-Content -Path $profilePath -Value "`r`n$functionContentDownload`r`n"

Write-Host "Las funciones de Descarga fueron agregadas al perfil de PowerShell de manera exitosa." -ForegroundColor Green