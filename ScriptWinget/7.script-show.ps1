##########################################################################################################
#                                    ADMINISTRADOR PERMISSIONS REQUIRED                                  #
#                                                                                                        #
#  This script will write the following functions to your Powershell Profile:                            #
#                                                                                                        #
#     * ShowInstallHelp                                                                                  #
#     * ShowSaveHelp                                                                                     #
#     * ShowUninstallHelp                                                                                #
#     * ShowUpdateHelp                                                                                   #
#     * ShowIdHelp                                                                                       #
#     * ShowUtilityHelp                                                                                  #
#     * ShowHelp                                                                                         #
#                                                                                                        #
##########################################################################################################
$functionContentShow = @'
##########################################################################################################
#                                              SHOW SCRIPTS                                              #
##########################################################################################################

function ShowInstallHelp {
    param(
        [string]$promptContent
    )
    Write-Host "Funciones de instalación disponibles, ingrese una opción:" -ForegroundColor DarkMagenta
    Write-Host "`t1. InstallAll" -ForegroundColor DarkMagenta
    Write-Host "`t2. InstallCustom" -ForegroundColor DarkMagenta
    Write-Host "`t3. InstallGeneral" -ForegroundColor DarkMagenta
    Write-Host "`t4. InstallDevelopment" -ForegroundColor DarkMagenta
    Write-Host "`t5. InstallBrowser" -ForegroundColor DarkMagenta
    Write-Host "`t6. InstallGame" -ForegroundColor DarkMagenta
    Write-Host "`t7. InstallSocial" -ForegroundColor DarkMagenta
    Write-Host "`t8. InstallConsole" -ForegroundColor DarkMagenta
    Write-Host "`t9. BlockingProgram" -ForegroundColor DarkMagenta
    Write-Host "`tShowInstallHelp(espacio+opción)" -ForegroundColor DarkMagenta
    Write-Host "`tShowHelp" -ForegroundColor DarkMagenta
    
    switch ($promptContent) {
        "1" {
            Write-Host "Ejecutando funcion 'InstallAll'." -ForegroundColor DarkBlue
            InstallAll
        }
        "2" {
            Write-Host "Ejecutando funcion 'InstallCustom'." -ForegroundColor DarkBlue
            InstallCustom
        }
        "3" {
            Write-Host "Ejecutando funcion 'InstallGeneral'." -ForegroundColor DarkBlue
            InstallGeneral
        }
        "4" {
            Write-Host "Ejecutando funcion 'InstallDevelopment'." -ForegroundColor DarkBlue
            InstallDevelopment
        }
        "5" {
            Write-Host "Ejecutando funcion 'InstallBrowser'." -ForegroundColor DarkBlue
            InstallBrowser
        }
        "6" {
            Write-Host "Ejecutando funcion 'InstallGame'." -ForegroundColor DarkBlue
            InstallGame
        }
        "7" {
            Write-Host "Ejecutando funcion 'InstallSocial'." -ForegroundColor DarkBlue
            InstallSocial
        }
        "8" {
            Write-Host "Ejecutando funcion 'InstallConsole'." -ForegroundColor DarkBlue
            InstallConsole
        }
        "9" {
            Write-Host "Ejecutando funcion 'BlockingProgram '." -ForegroundColor DarkBlue
            BlockingProgram 
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

function ShowSaveHelp {
    param(
        [string]$promptContent
    )
    Write-Host "Funciones de descarga disponibles, ingrese una opción:" -ForegroundColor DarkMagenta
    Write-Host "`t1. SaveAll" -ForegroundColor DarkMagenta
    Write-Host "`t2. SaveGeneral" -ForegroundColor DarkMagenta
    Write-Host "`t3. SaveDevelopment" -ForegroundColor DarkMagenta
    Write-Host "`t4. SaveBrowser" -ForegroundColor DarkMagenta
    Write-Host "`t5. SaveGame" -ForegroundColor DarkMagenta
    Write-Host "`t6. SaveSocial" -ForegroundColor DarkMagenta
    Write-Host "`t7. SaveConsole" -ForegroundColor DarkMagenta
    Write-Host "`tShowSaveHelp(espacio+opción)" -ForegroundColor DarkMagenta
    Write-Host "`tShowHelp" -ForegroundColor DarkMagenta
    switch ($promptContent) {
        "1" {
            Write-Host "Ejecutando funcion 'SaveAll'." -ForegroundColor DarkBlue
            SaveAll
        }
        "2" {
            Write-Host "Ejecutando funcion 'SaveGeneral'." -ForegroundColor DarkBlue
            SaveGeneral
        }
        "3" {
            Write-Host "Ejecutando funcion 'SaveDevelopment'." -ForegroundColor DarkBlue
            SaveDevelopment
        }
        "4" {
            Write-Host "Ejecutando funcion 'SaveBrowser'." -ForegroundColor DarkBlue
            SaveBrowser
        }
        "5" {
            Write-Host "Ejecutando funcion 'SaveGame'." -ForegroundColor DarkBlue
            SaveGame
        }
        "6" {
            Write-Host "Ejecutando funcion 'SaveSocial'." -ForegroundColor DarkBlue
            SaveSocial
        }
        "7" {
            Write-Host "Ejecutando funcion 'SaveConsole'." -ForegroundColor DarkBlue
            SaveConsole
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

function ShowUninstallHelp {
    param(
        [string]$promptContent
    )
    Write-Host "Funciones de eliminación disponibles, ingrese una opción:" -ForegroundColor DarkMagenta
    Write-Host "`t1. UninstallAll" -ForegroundColor DarkMagenta
    Write-Host "`t2. UninstallGeneral" -ForegroundColor DarkMagenta
    Write-Host "`t3. UninstallDevelopment" -ForegroundColor DarkMagenta
    Write-Host "`t4. UninstallBrowser" -ForegroundColor DarkMagenta
    Write-Host "`t5. UninstallGame" -ForegroundColor DarkMagenta
    Write-Host "`t6. UninstallSocial" -ForegroundColor DarkMagenta
    Write-Host "`t7. UninstallConsole" -ForegroundColor DarkMagenta
    Write-Host "`tShowUninstallHelp(espacio+opción)" -ForegroundColor DarkMagenta
    Write-Host "`tShowHelp" -ForegroundColor DarkMagenta
    switch ($promptContent) {
        "1" {
            Write-Host "Ejecutando funcion 'UninstallAll'." -ForegroundColor DarkBlue
            UninstallAll
        }
        "2" {
            Write-Host "Ejecutando funcion 'UninstallGeneral'." -ForegroundColor DarkBlue
            UninstallGeneral
        }
        "3" {
            Write-Host "Ejecutando funcion 'UninstallDevelopment'." -ForegroundColor DarkBlue
            UninstallDevelopment
        }
        "4" {
            Write-Host "Ejecutando funcion 'UninstallBrowser'." -ForegroundColor DarkBlue
            UninstallBrowser
        }
        "5" {
            Write-Host "Ejecutando funcion 'UninstallGame'." -ForegroundColor DarkBlue
            UninstallGame
        }
        "6" {
            Write-Host "Ejecutando funcion 'UninstallSocial'." -ForegroundColor DarkBlue
            UninstallSocial
        }
        "7" {
            Write-Host "Ejecutando funcion 'UninstallConsole'." -ForegroundColor DarkBlue
            UninstallConsole
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

function ShowUpdateHelp {
    param(
        [string]$promptContent
    )
    Write-Host "Funciones disponibles, ingrese una opción:" -ForegroundColor DarkMagenta
    Write-Host "`t1. UpdateAll" -ForegroundColor DarkMagenta
    Write-Host "`t2. UpdateGeneral" -ForegroundColor DarkMagenta
    Write-Host "`t3. UpdateDevelopment" -ForegroundColor DarkMagenta
    Write-Host "`t4. UpdateBrowser" -ForegroundColor DarkMagenta
    Write-Host "`t5. UpdateGame" -ForegroundColor DarkMagenta
    Write-Host "`t6. UpdateSocial" -ForegroundColor DarkMagenta
    Write-Host "`t7. UpdateConsole" -ForegroundColor DarkMagenta
    Write-Host "`tShowUpdateHelp(espacio+opción)" -ForegroundColor DarkMagenta
    Write-Host "`tShowHelp" -ForegroundColor DarkMagenta
    switch ($promptContent) {
        "1" {
            Write-Host "Ejecutando funcion 'UpdateAll'." -ForegroundColor DarkBlue
            UpdateAll
        }
        "2" {
            Write-Host "Ejecutando funcion 'UpdateGeneral'." -ForegroundColor DarkBlue
            UpdateGeneral
        }
        "3" {
            Write-Host "Ejecutando funcion 'UpdateDevelopment'." -ForegroundColor DarkBlue
            UpdateDevelopment
        }
        "4" {
            Write-Host "Ejecutando funcion 'UpdateBrowser'." -ForegroundColor DarkBlue
            UpdateBrowser
        }
        "5" {
            Write-Host "Ejecutando funcion 'UpdateGame'." -ForegroundColor DarkBlue
            UpdateGame
        }
        "6" {
            Write-Host "Ejecutando funcion 'UpdateSocial'." -ForegroundColor DarkBlue
            UpdateSocial
        }
        "7" {
            Write-Host "Ejecutando funcion 'UpdateConsole'." -ForegroundColor DarkBlue
            UpdateConsole
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

function ShowIdHelp {
    param (
        [string]$promptContent
    )
    Write-Host "Funciones disponibles, ingrese una opción:" -ForegroundColor DarkMagenta
    Write-Host "`t1. ShowId" -ForegroundColor DarkMagenta
    Write-Host "`t2. NewId" -ForegroundColor DarkMagenta
    Write-Host "`t3. RemoveId" -ForegroundColor DarkMagenta
    Write-Host "`t4. UpdateId" -ForegroundColor DarkMagenta
    Write-Host "`tShowIdHelp(espacio+opción)" -ForegroundColor DarkMagenta
    Write-Host "`tShowHelp" -ForegroundColor DarkMagenta
    
    switch ($promptContent) {
        "1"{
            Write-Host "Ejecutando funcion 'ShowId'." -ForegroundColor DarkBlue
            ShowId
        }
        "2"{
            Write-Host "Ejecutando funcion 'NewId'." -ForegroundColor DarkBlue
            NewId
        }
        "3"{
            Write-Host "Ejecutando funcion 'RemoveId'." -ForegroundColor DarkBlue
            RemoveId
        }
        "4"{
            Write-Host "Ejecutando funcion 'UpdateId'." -ForegroundColor DarkBlue
            UpdateId
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

function ShowUtilityHelp {
    param (
        [string]$promptContent
    )
    Write-Host "Funciones disponibles, ingrese una opción:" -ForegroundColor DarkMagenta
    Write-Host "`t1. Add-MenuWindows10" -ForegroundColor DarkMagenta
    Write-Host "`t2. Uninstall-MenuWindows10" -ForegroundColor DarkMagenta
    Write-Host "`t3. Export-DirectoryTree" -ForegroundColor DarkMagenta
    Write-Host "`t4. TestColor" -ForegroundColor DarkMagenta
    Write-Host "`tShowUtilityHelp(espacio+opción)" -ForegroundColor DarkMagenta
    Write-Host "`tShowHelp" -ForegroundColor DarkMagenta
    
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
            Write-Host "Ejecutando funcion 'TestColor'." -ForegroundColor DarkBlue
            TestColor
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

function ShowHelp {
    Write-Host "Las funciones para mostrar información son:" -ForegroundColor DarkMagenta
    Write-Host "`tShowInstallHelp" -ForegroundColor DarkMagenta
    Write-Host "`tShowSaveHelp" -ForegroundColor DarkMagenta
    Write-Host "`tShowUninstallHelp" -ForegroundColor DarkMagenta
    Write-Host "`tShowUpdateHelp" -ForegroundColor DarkMagenta
    Write-Host "`tShowIdHelp" -ForegroundColor DarkMagenta
    Write-Host "`tShowUtilityHelp" -ForegroundColor DarkMagenta
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