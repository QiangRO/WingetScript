##########################################################################################################
#                                    ADMINISTRADOR PERMISSIONS REQUIRED                                  #
#                                                                                                        #
#  This script will write the following functions to your Powershell Profile:                            #
#                                                                                                        #
#     * Show-InstallHelp                                                                                 #
#     * Show-SaveHelp                                                                                    #
#     * Show-UninstallHelp                                                                               #
#     * Show-UpdateHelp                                                                                  #
#     * Show-IdHelp                                                                                      #
#     * Show-UtilityHelp                                                                                 #
#     * Test-Color                                                                                       #
#     * Show-Help                                                                                        #
#                                                                                                        #
##########################################################################################################
$functionContentShow = @'
##########################################################################################################
#                                              SHOW SCRIPTS                                              #
##########################################################################################################

function Show-InstallHelp {
    param(
        [string]$promptContent
    )
    Write-Host "Funciones de instalación disponibles, ingrese una opción:" -ForegroundColor DarkMagenta
    Write-Host "`t1. Install-All" -ForegroundColor DarkMagenta
    Write-Host "`t2. Install-CustomProgram" -ForegroundColor DarkMagenta
    Write-Host "`t3. Install-GeneralPrograms" -ForegroundColor DarkMagenta
    Write-Host "`t4. Install-DevelopmentPrograms" -ForegroundColor DarkMagenta
    Write-Host "`t5. Install-Browsers" -ForegroundColor DarkMagenta
    Write-Host "`t6. Install-Games" -ForegroundColor DarkMagenta
    Write-Host "`t7. Install-SocialNetworks" -ForegroundColor DarkMagenta
    Write-Host "`t8. Install-ConsolePrograms" -ForegroundColor DarkMagenta
    Write-Host "`t9. Blocking-Programs" -ForegroundColor DarkMagenta
    Write-Host "`tShow-InstallHelp(espacio+opción)" -ForegroundColor DarkMagenta
    Write-Host "`tShow-Help" -ForegroundColor DarkMagenta
    
    switch ($promptContent) {
        "1" {
            Write-Host "Ejecutando funcion 'Install-All'." -ForegroundColor DarkBlue
            Install-All
        }
        "2" {
            Write-Host "Ejecutando funcion 'Install-CustomProgram'." -ForegroundColor DarkBlue
            Install-CustomProgram
        }
        "3" {
            Write-Host "Ejecutando funcion 'Install-GeneralPrograms'." -ForegroundColor DarkBlue
            Install-GeneralPrograms
        }
        "4" {
            Write-Host "Ejecutando funcion 'Install-DevelopmentPrograms'." -ForegroundColor DarkBlue
            Install-DevelopmentPrograms
        }
        "5" {
            Write-Host "Ejecutando funcion 'Install-Browsers'." -ForegroundColor DarkBlue
            Install-Browsers
        }
        "6" {
            Write-Host "Ejecutando funcion 'Install-Games'." -ForegroundColor DarkBlue
            Install-Games
        }
        "7" {
            Write-Host "Ejecutando funcion 'Install-SocialNetworks'." -ForegroundColor DarkBlue
            Install-SocialNetworks
        }
        "8" {
            Write-Host "Ejecutando funcion 'Install-ConsolePrograms'." -ForegroundColor DarkBlue
            Install-ConsolePrograms
        }
        "9" {
            Write-Host "Ejecutando funcion 'Blocking-Programs '." -ForegroundColor DarkBlue
            Blocking-Programs 
        }
        default {
            if ($promptContent -eq "") {
                Write-Host "Usted debe ingresar una opción" -ForegroundColor Yellow
            }
            else {
                Write-Host "La opcion ingresada no es valida." -ForegroundColor Red
            }
        }
    }
}

function Show-SaveHelp {
    param(
        [string]$promptContent
    )
    Write-Host "Funciones de descarga disponibles, ingrese una opción:" -ForegroundColor DarkMagenta
    Write-Host "`t1. Save-All" -ForegroundColor DarkMagenta
    Write-Host "`t2. Save-GeneralPrograms" -ForegroundColor DarkMagenta
    Write-Host "`t3. Save-DevelopmentPrograms" -ForegroundColor DarkMagenta
    Write-Host "`t4. Save-Browsers" -ForegroundColor DarkMagenta
    Write-Host "`t5. Save-Games" -ForegroundColor DarkMagenta
    Write-Host "`t6. Save-SocialNetworks" -ForegroundColor DarkMagenta
    Write-Host "`t7. Save-ConsolePrograms" -ForegroundColor DarkMagenta
    Write-Host "`tShow-SaveHelp(espacio+opción)" -ForegroundColor DarkMagenta
    Write-Host "`tShow-Help" -ForegroundColor DarkMagenta
    switch ($promptContent) {
        "1" {
            Write-Host "Ejecutando funcion 'Save-All'." -ForegroundColor DarkBlue
            Save-All
        }
        "2" {
            Write-Host "Ejecutando funcion 'Save-GeneralPrograms'." -ForegroundColor DarkBlue
            Save-GeneralPrograms
        }
        "3" {
            Write-Host "Ejecutando funcion 'Save-DevelopmentPrograms'." -ForegroundColor DarkBlue
            Save-DevelopmentPrograms
        }
        "4" {
            Write-Host "Ejecutando funcion 'Save-Browsers'." -ForegroundColor DarkBlue
            Save-Browsers
        }
        "5" {
            Write-Host "Ejecutando funcion 'Save-Games'." -ForegroundColor DarkBlue
            Save-Games
        }
        "6" {
            Write-Host "Ejecutando funcion 'Save-SocialNetworks'." -ForegroundColor DarkBlue
            Save-SocialNetworks
        }
        "7" {
            Write-Host "Ejecutando funcion 'Save-ConsolePrograms'." -ForegroundColor DarkBlue
            Save-ConsolePrograms
        }
        default {
            if ($promptContent -eq "") {
                Write-Host "Usted debe ingresar una opción" -ForegroundColor Yellow
            }
            else {
                Write-Host "La opcion ingresada no es valida." -ForegroundColor Red
            }
        }
    }
}

function Show-UninstallHelp {
    param(
        [string]$promptContent
    )
    Write-Host "Funciones de eliminación disponibles, ingrese una opción:" -ForegroundColor DarkMagenta
    Write-Host "`t1. Uninstall-All" -ForegroundColor DarkMagenta
    Write-Host "`t2. Uninstall-GeneralPrograms" -ForegroundColor DarkMagenta
    Write-Host "`t3. Uninstall-DevelopmentPrograms" -ForegroundColor DarkMagenta
    Write-Host "`t4. Uninstall-Browsers" -ForegroundColor DarkMagenta
    Write-Host "`t5. Uninstall-Games" -ForegroundColor DarkMagenta
    Write-Host "`t6. Uninstall-SocialNetworks" -ForegroundColor DarkMagenta
    Write-Host "`t7. Uninstall-ConsolePrograms" -ForegroundColor DarkMagenta
    Write-Host "`tShow-UninstallHelp(espacio+opción)" -ForegroundColor DarkMagenta
    Write-Host "`tShow-Help" -ForegroundColor DarkMagenta
    switch ($promptContent) {
        "1" {
            Write-Host "Ejecutando funcion 'Uninstall-All'." -ForegroundColor DarkBlue
            Uninstall-All
        }
        "2" {
            Write-Host "Ejecutando funcion 'Uninstall-GeneralPrograms'." -ForegroundColor DarkBlue
            Uninstall-GeneralPrograms
        }
        "3" {
            Write-Host "Ejecutando funcion 'Uninstall-DevelopmentPrograms'." -ForegroundColor DarkBlue
            Uninstall-DevelopmentPrograms
        }
        "4" {
            Write-Host "Ejecutando funcion 'Uninstall-Browsers'." -ForegroundColor DarkBlue
            Uninstall-Browsers
        }
        "5" {
            Write-Host "Ejecutando funcion 'Uninstall-Games'." -ForegroundColor DarkBlue
            Uninstall-Games
        }
        "6" {
            Write-Host "Ejecutando funcion 'Uninstall-SocialNetworks'." -ForegroundColor DarkBlue
            Uninstall-SocialNetworks
        }
        "7" {
            Write-Host "Ejecutando funcion 'Uninstall-ConsolePrograms'." -ForegroundColor DarkBlue
            Uninstall-ConsolePrograms
        }
        default {
            if ($promptContent -eq "") {
                Write-Host "Usted debe ingresar una opción" -ForegroundColor Yellow
            }
            else {
                Write-Host "La opcion ingresada no es valida." -ForegroundColor Red
            }
        }
    }
}

function Show-UpdateHelp {
    param(
        [string]$promptContent
    )
    Write-Host "Funciones disponibles, ingrese una opción:" -ForegroundColor DarkMagenta
    Write-Host "`t1. Update-All" -ForegroundColor DarkMagenta
    Write-Host "`t2. Update-GeneralPrograms" -ForegroundColor DarkMagenta
    Write-Host "`t3. Update-DevelopmentPrograms" -ForegroundColor DarkMagenta
    Write-Host "`t4. Update-Browsers" -ForegroundColor DarkMagenta
    Write-Host "`t5. Update-Games" -ForegroundColor DarkMagenta
    Write-Host "`t6. Update-SocialNetworks" -ForegroundColor DarkMagenta
    Write-Host "`t7. Update-ConsolePrograms" -ForegroundColor DarkMagenta
    Write-Host "`tShow-UpdateHelp(espacio+opción)" -ForegroundColor DarkMagenta
    Write-Host "`tShow-Help" -ForegroundColor DarkMagenta
    switch ($promptContent) {
        "1" {
            Write-Host "Ejecutando funcion 'Update-All'." -ForegroundColor DarkBlue
            Update-All
        }
        "2" {
            Write-Host "Ejecutando funcion 'Update-GeneralPrograms'." -ForegroundColor DarkBlue
            Update-GeneralPrograms
        }
        "3" {
            Write-Host "Ejecutando funcion 'Update-DevelopmentPrograms'." -ForegroundColor DarkBlue
            Update-DevelopmentPrograms
        }
        "4" {
            Write-Host "Ejecutando funcion 'Update-Browsers'." -ForegroundColor DarkBlue
            Update-Browsers
        }
        "5" {
            Write-Host "Ejecutando funcion 'Update-Games'." -ForegroundColor DarkBlue
            Update-Games
        }
        "6" {
            Write-Host "Ejecutando funcion 'Update-SocialNetworks'." -ForegroundColor DarkBlue
            Update-SocialNetworks
        }
        "7" {
            Write-Host "Ejecutando funcion 'Update-ConsolePrograms'." -ForegroundColor DarkBlue
            Update-ConsolePrograms
        }
        default {
            if ($promptContent -eq "") {
                Write-Host "Usted debe ingresar una opción" -ForegroundColor Yellow
            }
            else {
                Write-Host "La opcion ingresada no es valida." -ForegroundColor Red
            }
        }
    }
}

function Show-IdHelp {
    param (
        [string]$promptContent
    )
    Write-Host "Funciones disponibles, ingrese una opción:" -ForegroundColor DarkMagenta
    Write-Host "`t1. Show-Id" -ForegroundColor DarkMagenta
    Write-Host "`t2. New-Id" -ForegroundColor DarkMagenta
    Write-Host "`t3. Remove-Id" -ForegroundColor DarkMagenta
    Write-Host "`t4. Update-Id" -ForegroundColor DarkMagenta
    Write-Host "`tShow-IdHelp(espacio+opción)" -ForegroundColor DarkMagenta
    Write-Host "`tShow-Help" -ForegroundColor DarkMagenta
    
    switch ($promptContent) {
        "1"{
            Write-Host "Ejecutando funcion 'Show-Id'." -ForegroundColor DarkBlue
            Show-Id
        }
        "2"{
            Write-Host "Ejecutando funcion 'New-Id'." -ForegroundColor DarkBlue
            New-Id
        }
        "3"{
            Write-Host "Ejecutando funcion 'Remove-Id'." -ForegroundColor DarkBlue
            Remove-Id
        }
        "4"{
            Write-Host "Ejecutando funcion 'Update-Id'." -ForegroundColor DarkBlue
            Update-Id
        }
        Default {
            if ($promptContent -eq "") {
                Write-Host "Usted debe ingresar una opción" -ForegroundColor Yellow
            }
            else {
                Write-Host "La opcion ingresada no es valida." -ForegroundColor Red
            }
        }
    }
}

function Show-UtilityHelp {
    param (
        [string]$promptContent
    )
    Write-Host "Funciones disponibles, ingrese una opción:" -ForegroundColor DarkMagenta
    Write-Host "`t1. Add-MenuWindows10" -ForegroundColor DarkMagenta
    Write-Host "`t2. Uninstall-MenuWindows10" -ForegroundColor DarkMagenta
    Write-Host "`t3. Export-DirectoryTree" -ForegroundColor DarkMagenta
    Write-Host "`t4. Test-Color" -ForegroundColor DarkMagenta
    Write-Host "`tShow-UtilityHelp(espacio+opción)" -ForegroundColor DarkMagenta
    Write-Host "`tShow-Help" -ForegroundColor DarkMagenta
    
    switch ($promptContent) {
        "1"{
            Write-Host "Ejecutando funcion 'Add-MenuWindows10'." -ForegroundColor DarkBlue
            Add-MenuWindows10
        }
        "2"{
            Write-Host "Ejecutando funcion 'Uninstall-MenuWindows10'." -ForegroundColor DarkBlue
            Uninstall-MenuWindows10
        }   
        "3"{
            Write-Host "Ejecutando funcion 'Export-DirectoryTree'." -ForegroundColor DarkBlue
            Export-DirectoryTree
        }
        "4"{
            Write-Host "Ejecutando funcion 'Test-Color'." -ForegroundColor DarkBlue
            Test-Color
        }
        Default {
            if ($promptContent -eq "") {
                Write-Host "Usted debe ingresar una opción" -ForegroundColor Yellow
            }
            else {
                Write-Host "La opcion ingresada no es valida." -ForegroundColor Red
            }
        }
    }
}

function Show-Help {
    Write-Host "Las funciones para mostrar información son:" -ForegroundColor DarkMagenta
    Write-Host "`tShow-InstallHelp" -ForegroundColor DarkMagenta
    Write-Host "`tShow-SaveHelp" -ForegroundColor DarkMagenta
    Write-Host "`tShow-UninstallHelp" -ForegroundColor DarkMagenta
    Write-Host "`tShow-UpdateHelp" -ForegroundColor DarkMagenta
    Write-Host "`tShow-IdHelp" -ForegroundColor DarkMagenta
    Write-Host "`tShow-UtilityHelp" -ForegroundColor DarkMagenta
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

Add-Content -Path $profilePath -Value "`r`n$functionContentShow`r`n"

Write-Host "Las funciones de Mostrar fueron agregadas al perfil de PowerShell de manera exitosa." -ForegroundColor Green