##########################################################################################################
#                                    ADMINISTRADOR PERMISSIONS REQUIRED                                  #
#                                                                                                        #
#  This script will write the following functions to your Powershell Profile:                            #
#                                                                                                        #
#     * Get-ProgramJson.                                                                                 #
#     * Test-And-Install-Dependencies.                                                                   #
#     * Add-Initialization-Line.                                                                         #
#     * Install-All.                                                                                     #
#     * Install-Programs.                                                                                #
#     * Install-DevelopmentPrograms                                                                      #
#     * Install-Browsers.                                                                                #
#     * Install-Games.                                                                                   #
#     * Install-SocialNetworks.                                                                          #
#     * Install-ConsolePrograms.                                                                         #
#                                                                                                        #
##########################################################################################################

#C:\Users\aroch\AppData\Local\Programs\oh-my-posh\themes
#oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\my-theme.omp.json" | Invoke-Expression

#Ruta SSMS
#C:\Program Files (x86)\Microsoft SQL Server Management Studio 20

#Para script no firmado:                                Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope CurrentUser
#Para mas seguridad del sistema:                        Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
#Se ejecuta la politica solo para la sesion actual      Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
#                                                       Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope LocalMachine
#Restringir la ejecucion de todos los scripts           Set-ExecutionPolicy -ExecutionPolicy Restricted -Scope LocalMachine
#Restringir solo para la sesion actual                  Set-ExecutionPolicy -ExecutionPolicy Restricted -Scope Process


#Cambiar al menu contextual de windows 10
#New-Item -Path "HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" -Value "" -Force

#Cambiar al menu contextual de windows 11
#Remove-Item -Path "HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32"

#rutas de perfil
#Powershellcore:
#C:\Users\aroch\OneDrive\Documentos\PowerShell\Microsoft.PowerShell_profile.ps1
#Powershell:
#C:\Users\aroch\OneDrive\Documentos\WindowsPowerShell\Microsoft.PowerShell_profile.ps1

#ruta settings winget
#winget settings
#C:\Users\aroch\AppData\Local\Packages\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe\LocalState

Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass

$functionContentInstall = @'

#OBTENEMOS LA RUTA DEL SCRIPT (POWERSHELL)
# $scriptPath = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
# $scriptIdProgramPath = Join-Path -Path $scriptPath -ChildPath "ProgramasId.ps1"

#ARCHIVO DE ID'S
# . "$scriptIdProgramPath"

##########################################################################################################
#                                            UPLOAD DATA JSON                                            #
##########################################################################################################
$scriptPath = Split-Path -Path $PROFILE
$jsonPath = Join-Path -Path $scriptPath -ChildPath "ProgramasId.json"

if (Test-Path -Path $jsonPath) {
    $global:ProgramData = Get-Content -Path $jsonPath | ConvertFrom-Json
    Write-Host "Datos del archivo JSON fueron cargados." -ForegroundColor Green
}
else {
    Write-Host "Error: No se encontró el archivo ProgramasId.json" -ForegroundColor Red
}

if (-not $global:ProgramData) {
    Write-Host "Error: No se han cargado los programas. Ejecute `. $PROFILE` para recargar." -ForegroundColor Red
    return
}

function Get-ProgramJson {
    param (
        [string]$category
    )

    if (-not $global:ProgramData) {
        Write-Host "Error: No se han cargado los programas. Ejecute `. $PROFILE` para recargar." -ForegroundColor Red
        return @()  # Devolvemos un array vacío para evitar errores en los `foreach`
    }

    if ($global:ProgramData.PSObject.Properties.Name -contains $category) {
        return $global:ProgramData.$category
    }
    else {
        Write-Host "Error: La categoría '$category' no existe en el JSON." -ForegroundColor Red
        return @()
    }
}


#COMPROBAMOS SI LA INSTANCIA SE EJECUTA COMO ADMINISTRADOR
# $currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())

#VARIABLES GLOBALES
$downloadsPath = [System.IO.Path]::Combine($env:USERPROFILE, 'Downloads')

# $scriptPath = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
# $parentPath = Split-Path -Path $scriptPath -Parent

# function Start-CopyKeepass {
#     $keepassScriptPath = Join-Path -Path $parentPath -ChildPath "CopyableFiles\Keepass\copy-plugins-database.ps1"
#     Write-Host "Inicializando el script de Keepass: $keepassScriptPath" -ForegroundColor Cyan
#     & $keepassScriptPath
# }

##########################################################################################################
#                                           DEPENDENCY SCRIPTS                                           #
##########################################################################################################

function Test-And-Install-Dependencies {
    param(
        [string]$programName
    )
    switch ($programName) {
        #TESTEAR VALIDACIONES
        "Microsoft.DotNet.SDK.8" {
            $DotNet8Bolean = $true
            $DotNetPreviewBolean = $true
            $dotnetSdks = dotnet --list-sdks
            if ($dotnetSdks -notmatch "8\.") {
                Write-Host "Microsoft DotNet SDK 8.x no está instalado. Procediendo con la instalación $programName." -ForegroundColor DarkBlue
                if (-not (winget install -e --id $programName)) {
                    Write-Host "Error al instalar $programName" -ForegroundColor Red
                    $DotNet8Bolean = $false
                }
            }
            else {
                Write-Host "$programName ya está instalado." -ForegroundColor Green
            }if ($dotnetSdks -notmatch "preview") {
                Write-Host "No se encontró ninguna versión de DotNet SDK Preview. Procediendo con la instalación." -ForegroundColor DarkBlue
                if (-not (winget install -e --id Microsoft.DotNet.SDK.Preview)) {
                    Write-Host "Error al instalar DotNet SDK Preview" -ForegroundColor Red
                    $DotNetPreviewBolean = $false
                }
            }
            else {
                Write-Host "Alguna versión de DotNet SDK Preview ya está instalada." -ForegroundColor Green
            }

            #Evaluacion de variables Bolean
            if ($DotNet8Bolean -and $DotNetPreviewBolean) {
                Write-Host "Ambos Dotnet estan correctamente instalados" -ForegroundColor Green
                return $true
            }
            elseif (-not $DotNet8Bolean) {
                Write-Host "La instalacion de DotNet SDK 8.x falló." -ForegroundColor Red
                return $false
            }
            elseif (-not $DotNetPreviewBolean) {
                Write-Host "La instalacion de DotNet SDK Preview falló." -ForegroundColor Red
                return $false
            }
        }

        "Microsoft.VisualStudioCode" {
            if (-not (Test-And-Install-Dependencies -programName "Microsoft.DotNet.SDK.8")) {
                Write-Host "Algo salió mal al instalar las dependencias para $programName." -ForegroundColor Red
                return $false
            }
            else {
                Write-Host "Todas las dependencias de $programName están instaladas." -ForegroundColor Green
                if (-Not (winget list --id Microsoft.VisualStudioCode)) {
                    Write-Host "Instalando $programName..." -ForegroundColor DarkBlue
                    if (-not (winget install -e --id $programName)) {
                        Write-Host "Error al instalar $programName." -ForegroundColor Red
                        return $false
                    }
                }
                else {
                    Write-Host "$programName ya está instalado." -ForegroundColor Green
                }
                return $true
            }
        }
        "Microsoft.VisualStudio.2022.BuildTools" {
            $buildToolsPath = "C:\Program Files (x86)\Microsoft Visual Studio\2022\BuildTools\MSBuild\Current\Bin"
            if (-Not (Test-Path $buildToolsPath)) {
                Write-Host "Microsoft Build Tools no está instalado. Procediendo con la instalación..." -ForegroundColor DarkBlue
                if (-not (winget install -e --id $programName)) {
                    Write-Host "Error al instalar Microsoft Build Tools." -ForegroundColor Red
                    return $false
                }
            }
            else {
                Write-Host "Microsoft Build Tools ya está instalado." -ForegroundColor Green
            }
            return $true
        }
        
        "Rustlang.Rustup" {
            #Su dependencia es Microsoft BuildTools
            $rustupCommand = Get-Command rustup -ErrorAction SilentlyContinue
            if (-not (Test-And-Install-Dependencies -programName "Microsoft.VisualStudio.2022.BuildTools")) {
                Write-Host("Microsoft Build Tools no se encuentra instalado") -ForegroundColor Red
                return $false
            }
            else {
                if (-Not $rustupCommand) {
                    Write-Host "Rustup no está instalado. Procediendo con la instalación..." -ForegroundColor DarkBlue
                    winget install -e --id $programName
                }
                else {
                    Write-Host "Rustup ya se encuentra instalado" -ForegroundColor Green
                }
                return $true
            }
        }

        "Schniz.fnm" {
            #Su dependencia es Rustup
            if (-not (Test-And-Install-Dependencies -programName "Rustlang.Rustup") -or -not (Test-And-Install-Dependencies -programName "Microsoft.VisualStudio.2022.BuildTools")) {
                Write-Host "Algo salió mal al instalar las dependencias para fnm." -ForegroundColor Red
                return $false
            }
            else {
                Write-Host "Todas las dependencias de fnm están instaladas." -ForegroundColor Green
                return $true
            }
        }
        "Microsoft.VCRedist.2015+.x64" {
            $vcredistDllPath = "C:\Windows\System32\msvcp140.dll"
            if (-Not (Test-Path $vcredistDllPath)) {
                Write-Host "Microsoft Visual C++ 2015-2022 Redistributable (x64) no está instalado. Procediendo con la instalación..." -ForegroundColor DarkBlue
                if (-not(winget install -e --id $programName)) {
                    Write-Host "Error al instalar Microsoft Visual C++ 2015-2022 Redistributable (x64)." -ForegroundColor Red
                    return $false
                }
            }
            else {
                Write-Host "Microsoft Visual C++ 2015-2022 Redistributable (x64) ya está instalado." -ForegroundColor Green
            }
            return $true
        }
        "Oracle.VirtualBox" {
            #Su dependencia es Microsoft VCRedist
            if (-not(Test-And-Install-Dependencies -programName "Microsoft.VCRedist.2015+.x64")) {
                Write-Host "Algo salio mal al instalar las dependencias para VirtualBox." -ForegroundColor Red
                return $false
            }
            else {
                Write-Host "Todas las dependencias de VirtualBox estan instaladas." -ForegroundColor Green
                return $true
            }
        }
        default {
            Write-Host "Dependencia no reconocida." -ForegroundColor Yellow
            return $false
        }
    }
}

function Add-Initialization-Line {
    param (
        [string]$programID
    )
    switch ($programID) {
        "JanDeDobbeleer.OhMyPosh" {
            $ohmyposhInit = "oh-my-posh init pwsh --config 'C:\Users\aroch\AppData\Local\Programs\oh-my-posh\themes\my-theme.omp.json' | Invoke-Expression"
            $profilePath = $PROFILE
            $profileContent = Get-Content -Path $profilePath

            $lineExists = $false
            foreach ($line in $profileContent) {
                if ($line.Trim() -eq $ohmyposhInit) {
                    $lineExists = $true
                    break
                }
            }
            if (-not $lineExists) {
                Add-Content -Path $profilePath -Value "`r`n$ohmyposhInit`r`n"
                Write-Host "Inicialización de $programa añadida al perfil de PowerShell." -ForegroundColor Green
            }
            else {
                Write-Host "Inicialización de $programa ya existe en el perfil de PowerShell." -ForegroundColor Green
            }
        }
        "Schniz.fnm" {
            $fnmInit = "fnm env --use-on-cd --shell power-shell | Out-String | Invoke-Expression"
            $profilePath = $PROFILE
            $profileContent = Get-Content -Path $profilePath

            $lineExists = $false
            foreach ($line in $profileContent) {
                if ($line.Trim() -eq $fnmInit) {
                    $lineExists = $true
                    break
                }
            }
            if (-not $lineExists) {
                Add-Content -Path $profilePath -Value "`r`n$fnmInit`r`n"
                Write-Host "Inicialización de $programa añadida al perfil de PowerShell." -ForegroundColor Green
            }
            else {
                Write-Host "Inicialización de $programa ya existe en el perfil de PowerShell." -ForegroundColor Green
            }
        }
        "Terminal-Icons" {
            $iconsInit = "Import-Module -Name Terminal-Icons"
            $profilePath = $PROFILE
            $profileContent = Get-Content -Path $profilePath
            $lineExists = $false
            foreach ($line in $profileContent) {
                if ($line.Trim() -eq $iconsInit) {
                    $lineExists = $true
                    break
                }
            }
            if (-not $lineExists) {
                Add-Content -Path $profilePath -Value "`r`n$iconsInit`r`n"
                Write-Host "Inicialización de $programa añadida al perfil de PowerShell." -ForegroundColor Green
            }
            else {
                Write-Host "Inicialización de $programa ya existe en el perfil de PowerShell." -ForegroundColor Green
            }
        }
        default {
            Write-Host "Programa $programID no reconocido" -ForegroundColor Yellow
        }
    }
}

##########################################################################################################
#                                          INSTALLATION SCRIPTS                                          #
##########################################################################################################

function Install-Programs {
    Write-Host "Instalando Programs" -ForegroundColor Cyan

    $programs = Get-ProgramJson -category "programs"

    foreach ($programa in $programs) {
        Write-Host "Instalando $programa..." -ForegroundColor DarkBlue
        switch ($programa) {
            "Spotify.Spotify" {
                if (-not ($currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator))) {
                    winget install -e --id $programa
                }
                else {
                    Write-Host "$programa no se puede instalar con permisos elevados. Saltando instalacion." -ForegroundColor Yellow
                }

            }
            "DominikReichl.KeePass" {
                winget install -e --id $programa --location "D:\Programas\KeePass Password Safe 2"
                # Start-CopyKeepass
            }
            default {
                winget install -e --id $programa
            }
        }
    }
}

function Install-DevelopmentPrograms {
    Write-Host "Instalando programas Development" -ForegroundColor Cyan

    $developmentPrograms = Get-ProgramJson -category "developmentPrograms"

    foreach ($programa in $developmentPrograms) {
        Write-Host "Instalando $programa." -ForegroundColor DarkBlue
        switch ($programa) {
            "Schniz.fnm" {
                if (Test-And-Install-Dependencies -programName $programa) {
                    Write-Host "Procediendo con la instalación de $programa" -ForegroundColor DarkBlue
                    if (-not (winget install -e --id $programa)) {
                        Write-Host "Error al instalar fnm." -ForegroundColor Red
                    }
                    Add-Initialization-Line -programID $programa
                }
                else {
                    Write-Host "No se pudieron instalar todas las dependencias para fnm. Instalación abortada." -ForegroundColor Red
                }
            }
            "Git.Git" {
                winget install $programa --override '/VERYSILENT /NORESTART /NOCANCEL /SP- /CLOSEAPPLICATIONS /o:COMPONENTS=icons,ext\reg\shellhere,gitlfs,assoc,assoc_sh /o:EditorOption=VisualStudioCode /o:DefaultBranchOption=main /o:PathOption=Cmd /o:SSHOption=OpenSSH /o:CurlOption=OpenSSL /o:CRLFOption=CRLFAlways /o:BashTerminalOption=MinTTY /o:GitPullBehaviorOption=Merge /o:UseCredentialManager=Enabled /o:PerformanceTweaksFSCache=Enabled /o:EnablePseudoConsoleSupport=Disabled'
            }
            "Microsoft.SQLServer.2022.Developer" {
                winget install -e --id $programa --override "/ENU /IACCEPTSQLSERVERLICENSETERMS /QUIET /HIDEPROGRESSBAR /VERBOSE /ACTION=Install /LANGUAGE=en-US"
            }
            "Microsoft.SQLServerManagementStudio" {
                winget install -e --id $programa --override "/INSTALL /QUIET /NORESTART"
            }
            "Oracle.VirtualBox" {
                if (Test-And-Install-Dependencies -programName $programa) {
                    Write-Host "Procediendo con la instalación de VirtualBox..." -ForegroundColor DarkBlue
                    if (-not (winget install -e --id $programa --override "--silent --ignore-reboot")) {
                        Write-Host "Error al instalar VirtualBox." -ForegroundColor Red
                    }
                }
                else {
                    Write-Host "No se pudieron instalar todas las dependencias para VirtualBox. Instalación abortada." -ForegroundColor Red
                }
            }
            "Microsoft.VisualStudioCode" {
                if (Test-And-Install-Dependencies -programName "Microsoft.VisualStudioCode") {
                    winget install $programa --override '/VERYSILENT /SP- /MERGETASKS="!runcode,!desktopicon,!quicklaunchicon,addcontextmenufiles,addcontextmenufolders,associatewithfiles,addtopath"'
                }
            }
            "ApacheFriends.Xampp.8.2" {
                $xamppPhpPath = "C:\xampp\php"
                winget install -e --id $programa
                #Añadiendo php a las variables de entorno del sistema
                if (Test-Path -Path $xamppPhpPath) {
                    $currentPath = [System.Environment]::GetEnvironmentVariable("Path", [System.EnvironmentVariableTarget]::Machine)
                    if (-not $currentPath.Contains($xamppPhpPath)) {
                        $newPath = $currentPath + ";" + $xamppPhpPath
                        [System.Environment]::SetEnvironmentVariable("Path", $newPath, [System.EnvironmentVariableTarget]::Machine)

                        Write-Host "El directorio '$xamppPhpPath' se ha añadido al PATH del sistema correctamente." -ForegroundColor Green
                    }
                    else {
                        Write-Host "El directorio '$xamppPhpPath' ya está en el PATH del sistema." -ForegroundColor Green
                    }
                }
                else {
                    Write-Host "El directorio '$xamppPhpPath' no existe. Asegúrate de que XAMPP esté instalado correctamente." -ForegroundColor Red
                }
            }
            default {
                winget install -e --id $programa
            }
        }
    }
}

function Install-Browsers {
    Write-Host "Instalando programas Browser" -ForegroundColor Cyan

    $browserPrograms = Get-ProgramJson -category "browserPrograms"

    foreach ($programa in $browserPrograms) {
        Write-Host "Instalando $programa..." -ForegroundColor DarkBlue
        winget install -e --id $programa
    }
}

function Install-Games {
    Write-Host "Instalando programas Gaming" -ForegroundColor Cyan
    
    $gamingPrograms = Get-ProgramJson -category "gamingPrograms"

    $gamingPrograms = $global:ProgramData.gamingPrograms
    foreach ($programa in $gamingPrograms) {
        Write-Host "Instalando $programa..." -ForegroundColor DarkBlue
        switch ($programa) {
            "Blizzard.BattleNet" {
                winget install -e --id $programa --custom '--lang=enUS --installpath="C:\Program Files (x86)\Battle.net"'
            }
            Default {}
        }
        winget install -e --id $programa
    }
}

function Install-SocialNetworks {
    Write-Host "Instalando programas Social Network" -ForegroundColor Cyan

    $socialNetworkPrograms = Get-ProgramJson -category "socialNetworkPrograms"

    foreach ($programa in $socialNetworkPrograms) {
        Write-Host "Instalando $programa..." -ForegroundColor DarkBlue
        winget install -e --id $programa
    }
}

function Install-ConsolePrograms {
    Write-Host "Instalando programas Console" -ForegroundColor Cyan
    
    $consolePrograms = Get-ProgramJson -category "consolePrograms"

    foreach ($programa in $consolePrograms) {
        Write-Host "Instalando $programa" -ForegroundColor DarkBlue
        switch ($programa) {
            "JanDeDobbeleer.OhMyPosh" {
                Write-Host "Procediendo con la instalacion de $programa" -ForegroundColor DarkBlue
                if (-not (winget install -e --id $programa -s winget)) {
                    Write-Host "Error la instalar $programa" -ForegroundColor Red
                }
                Get-PoshThemes
                Add-Initialization-Line -programID $programa
            }
            "Terminal-Icons" {
                Install-Module -Name $programa -Repository PSGallery
                Add-Initialization-Line -programID $programa
            }
            default {
                winget install -e --id $programa
            }
        }
        
    }
}

function Install-All {
    Write-Host "Instalando todos los programas de la lista." -ForegroundColor DarkBlue
    Install-Programs
    Install-DevelopmentPrograms
    Install-Browsers
    Install-Games
    Install-SocialNetworks
    Install-ConsolePrograms
}
##########################################################################################################
#                                            UPDATE BLOCKING                                             #
##########################################################################################################

winget pin add --id Microsoft.VisualStudio.2022.Community --blocking
winget pin add --id Microsoft.VisualStudio.2022.BuildTools --blocking
winget pin add --id Unity.Unity.2021 --blocking
winget pin add --id Unity.Unity.2022 --blocking
winget pin add --id Unity.Unity.2023 --blocking
winget pin add --id BlenderFoundation.Blender --blocking
winget pin add --id BlenderFoundation.Blender.LTS.3.3 --blocking
winget pin add --id BlenderFoundation.Blender.LTS.3.6 --blocking
winget pin add --id Ubisoft.Connect --blocking
winget pin add --id Microsoft.Edge --blocking
'@

$profilePath = $PROFILE

$profileDir = [System.IO.Path]::GetDirectoryName($profilePath)
if (-not(Test-Path -Path $profileDir)) {
    Write-Host "El archivo de perfil no existe, se procedera a crearlo"
    New-Item -ItemType File -Path $PROFILE -Force
}
else {
    Write-Host "El archivo de perfil ya existe"
}

Add-Content -Path $profilePath -Value "`r`n$functionContentInstall`r`n"

Write-Host "Las funciones de Instalacion fueron agregadas al perfil de PowerShell de manera exitosa." -ForegroundColor Green