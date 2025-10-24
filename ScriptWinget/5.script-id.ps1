##########################################################################################################
#                                    ADMINISTRADOR PERMISSIONS REQUIRED                                  #
#                                                                                                        #
#  This script will write the following functions to your Powershell Profile:                            #
#                                                                                                        #
#     * Format-JsonValues                                                                                #
#     * ShowId                                                                                          #
#     * NewId                                                                                           #
#     * RemoveId                                                                                        #
#     * UpdateId                                                                                        #
#                                                                                                        #
##########################################################################################################
$functionContentAdd =@'
##########################################################################################################
#                                               ID SCRIPTS                                               #
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

function ShowId {
    param (
        [string]$newProgramID
    )

    Write-Host "Ruta del JSON: $jsonPath" -ForegroundColor Cyan

    $data = Get-Content -Path $jsonPath | ConvertFrom-Json
    $index = 0

    $table = foreach ($property in $data.PSObject.Properties) {
        [PSCustomObject]@{
            Index    = $index
            Categoria = $property.Name 
            IDs       = ($property.Value -join ', ')
        }
        $index++
    }
    $table | Format-Table -Wrap -AutoSize
}

function NewId {
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
    $index = 0

    $table = foreach ($property in $data.PSObject.Properties) {
        [PSCustomObject]@{
            Index    = $index
            Categoria = $property.Name 
            IDs       = ($property.Value -join ', ')
        }
        $index++
    }
    $table | Format-Table -Wrap -AutoSize
    
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

function RemoveId {
    param (
        [string]$targetId
    )

    if (-not (Test-Path -Path $jsonPath)) {
        Write-Host "Error: No se encontró el archivo JSON en la ruta proporcionada." -ForegroundColor Red
        return
    }

    if (-not $targetId) {
        Write-Host "Error: Debe ingresar un ID válido a eliminar." -ForegroundColor Red
        return
    }

    $data = Get-Content -Path $jsonPath | ConvertFrom-Json
    $index = 0
    $propertyList = @()

    Write-Host "`nSeleccione la categoría de la que desea eliminar el ID:`n" -ForegroundColor Cyan

    foreach ($property in $data.PSObject.Properties) {
        Write-Host "$index. $($property.Name):" -ForegroundColor Blue
        Write-Host "$($property.Value -join ', ')" -ForegroundColor DarkYellow
        $propertyList += $property.Name
        $index++
    }

    $userInput = Read-Host "Ingrese el número de la propiedad"

    if ($userInput -match "^\d+$" -and [int]$userInput -ge 0 -and [int]$userInput -lt $propertyList.Count) {
        $selectedProperty = $propertyList[[int]$userInput]
        Write-Host "`nPropiedad seleccionada: $selectedProperty`n"
    }
    else {
        Write-Host "Entrada inválida. Intente de nuevo." -ForegroundColor Red
        return
    }

    if ($data.$selectedProperty -contains $targetId) {
        $data.$selectedProperty = $data.$selectedProperty | Where-Object { $_ -ne $targetId }

        $data | ConvertTo-Json -Depth 3 | Set-Content -Path $jsonPath -Force
        Write-Host "ID '$targetId' eliminado correctamente de $selectedProperty." -ForegroundColor Green

        Format-JsonValues -jsonPath $jsonPath
    }
    else {
        Write-Host "El ID '$targetId' no se encontró en la propiedad $selectedProperty." -ForegroundColor Yellow
    }
}

function UpdateId {
    if (-not (Test-Path -Path $jsonPath)) {
        Write-Host "Error: No se encontró el archivo JSON en la ruta proporcionada." -ForegroundColor Red
        return
    }

    $data = Get-Content -Path $jsonPath | ConvertFrom-Json
    $propertyList = @()
    $index = 0

    Write-Host "`nSeleccione la categoría donde se encuentra el ID que desea modificar:`n" -ForegroundColor Cyan

    foreach ($property in $data.PSObject.Properties) {
        Write-Host "$index. $($property.Name):" -ForegroundColor Blue
        Write-Host "$($property.Value -join ', ')" -ForegroundColor DarkYellow
        $propertyList += $property.Name
        $index++
    }

    $userInput = Read-Host "Ingrese el número de la propiedad"
    if ($userInput -match "^\d+$" -and [int]$userInput -ge 0 -and [int]$userInput -lt $propertyList.Count) {
        $selectedProperty = $propertyList[[int]$userInput]
        Write-Host "`nPropiedad seleccionada: $selectedProperty`n"
    } else {
        Write-Host "Entrada inválida. Intente de nuevo." -ForegroundColor Red
        return
    }

    $idList = $data.$selectedProperty
    if ($idList.Count -eq 0) {
        Write-Host "La categoría '$selectedProperty' no contiene IDs para modificar." -ForegroundColor Yellow
        return
    }

    for ($i = 0; $i -lt $idList.Count; $i++) {
        Write-Host "$i. $($idList[$i])" -ForegroundColor DarkCyan
    }

    $idToEditIndex = Read-Host "Ingrese el número del ID que desea modificar"
    if ($idToEditIndex -match "^\d+$" -and [int]$idToEditIndex -ge 0 -and [int]$idToEditIndex -lt $idList.Count) {
        $oldId = $idList[$idToEditIndex]
        $newId = Read-Host "Ingrese el nuevo valor para el ID '$oldId'"

        if ([string]::IsNullOrWhiteSpace($newId)) {
            Write-Host "Error: El nuevo ID no puede estar vacío." -ForegroundColor Red
            return
        }

        if ($data.$selectedProperty -contains $newId) {
            Write-Host "El ID '$newId' ya existe en esta categoría. No se realizaron cambios." -ForegroundColor Yellow
            return
        }

        $data.$selectedProperty[$idToEditIndex] = $newId
        $data | ConvertTo-Json -Depth 3 | Set-Content -Path $jsonPath -Force

        Write-Host "ID actualizado: '$oldId' → '$newId'" -ForegroundColor Green
        Format-JsonValues -jsonPath $jsonPath
    } else {
        Write-Host "Entrada inválida. Intente de nuevo." -ForegroundColor Red
    }
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