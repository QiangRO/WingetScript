##########################################################################################################
#                                    ADMINISTRADOR PERMISSIONS REQUIRED                                  #
#                                                                                                        #
#  This script will write the following functions to your Powershell Profile:                            #
#                                                                                                        #
#     * Format-JsonValues.                                                                               #
#     * Add-ProgramId.                                                                                   #
#     * Add-MenuWindows10.                                                                              #
#     * Uninstall-MenuWindows10.                                                                        #
#     * Test-Color.                                                                                       #
#                                                                                                        #
##########################################################################################################
$functionContentAdd =
@'
##########################################################################################################
#                                               ADD SCRIPTS                                              #
##########################################################################################################
function Format-JsonValues {
    param (
        [string]$jsonPath
    )
    $data = Get-Content -Path $jsonPath | ConvertFrom-Json
    foreach ($property in $data.PSObject.Properties.Name) {
        if ($data.$property -is [System.Array]) {
            $data.$property = $data.$property | Sort-Object
        }
    }
    $data | ConvertTo-Json -Depth 10 | Set-Content -Path $jsonPath -Force
    Write-Host "Los valores en cada propiedad del JSON han sido ordenados alfabéticamente." -ForegroundColor Cyan
}


function Add-ProgramId {
    param (
        [string]$newProgramID
    )
    $index = 0
    $propertyList = @()

    if (-not $newProgramID) {
        Write-Host "Error: Debe ingresar un ID de programa válido." -ForegroundColor Red
        return  
    }

    Write-Host "Ruta del JSON: $jsonPath"

    $data = Get-Content -Path $jsonPath | ConvertFrom-Json

    foreach ($property in $data.PSObject.Properties) {
        Write-Host "$index. $($property.Name): " -ForegroundColor Blue
        Write-Host "$($property.Value -join ', ')" -ForegroundColor DarkYellow
        $propertyList += $property.Name
        $index++
    }
    $userInput = Read-Host "Ingrese el número de la propiedad a la que desea agregar el ID"

    if ($userInput -match "^\d+$" -and [int]$userInput -ge 0 -and [int]$userInput -lt $propertyList.Count) {
        $selectedProperty = $propertyList[[int]$userInput]
        Write-Host "Propiedad seleccionada: $selectedProperty"
    }
    else {
        Write-Host "Entrada inválida. Intente de nuevo." -ForegroundColor Red
    }

    if (-not($data.PSObject.Properties.Name -contains $selectedProperty)) {
        $data | Add-Member -MemberType NoteProperty -Name $selectedProperty -Value @()
    }
    if ($data.$selectedProperty -notcontains $newProgramID) {
        $data.$selectedProperty += $newProgramID
        $data | ConvertTo-Json -Depth 3 | Set-Content -Path $jsonPath -Force

        Write-Host "ID agregado correctamente a $selectedProperty." -ForegroundColor Green
        Format-JsonValues -jsonPath $jsonPath
    }
    else {
        Write-Host "El ID '$newProgramID' ya existe en $selectedProperty." -ForegroundColor Yellow
    }
}
##########################################################################################################
#                                      CONFIGURATION SYSTEM SCRIPTS                                      #
##########################################################################################################
function Add-MenuWindows10 {
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

function Uninstall-MenuWindows10 {
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

function Test-Color {
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