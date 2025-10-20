##########################################################################################################
#                                    ADMINISTRADOR PERMISSIONS REQUIRED                                  #
#                                                                                                        #
#  This script will write the following functions to your Powershell Profile:                            #
#                                                                                                        #
#     * AddWin10.                                                                               #
#     * Add-Win11.                                                                         #
#     * ExportDirectory                                                                             #
#     * TestColor                                                                                        #
#                                                                                                        #
#                                                                                                        #
##########################################################################################################
$functionContentAdd =
@'
##########################################################################################################
#                                      CONFIGURATION SYSTEM SCRIPTS                                      #
##########################################################################################################

function AddWin10 {
    $regPath = "HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32"
    if (!(Test-Path $regPath)) {
        Write-Host "Cambiando el menú contextual al estilo de Windows 10..." -ForegroundColor Yellow
        New-Item -Path $regPath -Force | Out-Null
        Set-ItemProperty -Path $regPath -Name "(default)" -Value "" | Out-Null
        Write-Host "El menú contextual ha sido cambiado al estilo de Windows 10." -ForegroundColor Green

        Write-Host "Reiniciando el Explorador de archivos..." -ForegroundColor Yellow
        taskkill /f /im explorer.exe | Out-Null
        Start-Process explorer.exe
    }
    else {
        Write-Host "La clave de registro ya existe. No hay cambios que agregar" -ForegroundColor Green
    }
}

function Add-Win11 {
    $regPath = "HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32"

    if (Test-Path $regPath) {
        Write-Host "Revirtiendo el menú contextual al estilo predeterminado de Windows 11..." -ForegroundColor Yellow
        Remove-Item -Path $regPath -Force
        Write-Host "El menú contextual ha sido revertido al estilo predeterminado de Windows 11." -ForegroundColor Green

        Write-Host "Reiniciando el Explorador de archivos..." -ForegroundColor Yellow
        taskkill /f /im explorer.exe | Out-Null
        Start-Process explorer.exe
    }
    else {
        Write-Host "La clave de registro no existe. No hay cambios que revertir." -ForegroundColor Green
    }
}

##########################################################################################################
#                                            UTILITY SCRIPTS                                             # ##########################################################################################################

function ExportDirectory {
    param(
        [Parameter(Mandatory = $true)]
        [string]$RootPath,

        [Parameter(Mandatory = $true)]
        [string]$OutputFile
    )

    # Función interna recursiva
    function Write-Tree {
        param(
            [string]$Path,
            [int]$Level
        )

        # Escribimos el nombre de la carpeta actual
        $indent = "`t#" * $Level
        Add-Content -Path $OutputFile -Value "$indent$(Split-Path -Path $Path -Leaf)"
        
        $script:processedItems++
        Write-Progress -Activity "Exportando árbol de carpetas..." `
                        -Status "Procesando: $($Path)" `
                        -PercentComplete (($script:processedItems / $script:totalItems) * 100)

        # Listamos primero las subcarpetas
        Get-ChildItem -Path $Path -Directory -Force | Sort-Object Name | ForEach-Object {
            Write-Tree -Path $_.FullName -Level ($Level + 1)
        }

        # Luego listamos los archivos
        Get-ChildItem -Path $Path -File -Force | Sort-Object Name | ForEach-Object {
            $fileIndent = "`t" * ($Level + 1)
            Add-Content -Path $OutputFile -Value "$fileIndent$($_.Name)"
            
            $script:processedItems++
            Write-Progress -Activity "Exportando árbol de carpetas..." `
                            -Status "Procesando: $($_.FullName)" `
                            -PercentComplete (($script:processedItems / $script:totalItems) * 100)
        }
    }

    # Validación inicial
    if (-not (Test-Path -Path $RootPath -PathType Container)) {
        Write-Error "La ruta especificada no existe o no es una carpeta: $RootPath"
        return
    }

    # Contamos el total de elementos (carpetas + archivos)
    Write-Host "Contando elementos..." -ForegroundColor Cyan
    $folders = Get-ChildItem -Path $RootPath -Recurse -Directory -Force
    $files = Get-ChildItem -Path $RootPath -Recurse -File -Force
    $script:totalItems = $folders.Count + $files.Count + 1  # +1 por la carpeta raíz
    $script:processedItems = 0

    # Inicializamos: borramos archivo si existe y creamos uno nuevo UTF-8 vacío
    New-Item -Path $OutputFile -ItemType File -Force | Out-Null
    Set-Content -Path $OutputFile -Value "Directorio: $RootPath" -Encoding utf8
    Add-Content -Path $OutputFile -Value ""  # Línea en blanco

    # Comenzamos a escribir el árbol
    Write-Tree -Path $RootPath -Level 0

    # Cerramos la barra de progreso
    Write-Progress -Activity "Exportación completada" -Completed
    Write-Host "El árbol de directorios fue exportado a: $OutputFile" -ForegroundColor Green
}

function TestColor {
    Write-Host "Esto es una prueba de colores." -ForegroundColor Black
    Write-Host "Esto es una prueba de colores." -ForegroundColor Blue
    Write-Host "Esto es una prueba de colores." -ForegroundColor Cyan
    Write-Host "Esto es una prueba de colores." -ForegroundColor Gray
    Write-Host "Esto es una prueba de colores." -ForegroundColor Green
    Write-Host "Esto es una prueba de colores." -ForegroundColor Magenta
    Write-Host "Esto es una prueba de colores." -ForegroundColor Red
    Write-Host "Esto es una prueba de colores." -ForegroundColor White
    Write-Host "Esto es una prueba de colores." -ForegroundColor Yellow
    Write-Host "Esto es una prueba de colores." -ForegroundColor DarkBlue
    Write-Host "Esto es una prueba de colores." -ForegroundColor DarkCyan
    Write-Host "Esto es una prueba de colores." -ForegroundColor DarkGray
    Write-Host "Esto es una prueba de colores." -ForegroundColor DarkGreen
    Write-Host "Esto es una prueba de colores." -ForegroundColor DarkMagenta
    Write-Host "Esto es una prueba de colores." -ForegroundColor DarkRed
    Write-Host "Esto es una prueba de colores." -ForegroundColor DarkYellow
}
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

Add-Content -Path $profilePath -Value "`r`n$functionContentAdd`r`n"

Write-Host "Las funciones de Agregar-Programas fueron agregadas al perfil de PowerShell de manera exitosa." -ForegroundColor Green