# Ruta de las carpetas que contienen las fuentes (Hack y FiraCode)
$fontDirectories = @(
    (Join-Path -Path $PSScriptRoot -ChildPath "Hack"),
    (Join-Path -Path $PSScriptRoot -ChildPath "FiraCode")
)

# Ruta de destino en C:\Windows\Fonts
$fontsFolderPath = "$env:WINDIR\Fonts"

# Asegurar que la carpeta de fuentes exista
if (-Not (Test-Path -Path $fontsFolderPath)) {
    New-Item -Path $fontsFolderPath -ItemType Directory -Force
}

# Registrar fuentes en el Registry
$registryPath = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts"

foreach ($sourcePath in $fontDirectories) {
    $fontFiles = Get-ChildItem -Path $sourcePath -Filter *.ttf

    foreach ($fontFile in $fontFiles) {
        $destinationPath = "$fontsFolderPath\$($fontFile.Name)"

        # Copiar la fuente si no existe
        if (-Not (Test-Path -Path $destinationPath)) {
            Write-Host "Instalando $($fontFile.Name)..." -ForegroundColor Green
            Copy-Item -Path $fontFile.FullName -Destination $destinationPath -Force
        } else {
            Write-Host "La fuente $($fontFile.Name) ya existe en Fonts." -ForegroundColor Yellow
        }

        # Registrar la fuente en el Registry (requiere admin)
        $fontName = $fontFile.BaseName
        $registryName = "$fontName (TrueType)"

        try {
            if (-Not (Get-ItemProperty -Path $registryPath -Name $registryName -ErrorAction SilentlyContinue)) {
                Set-ItemProperty -Path $registryPath -Name $registryName -Value $fontFile.Name
                Write-Host "Registrando $($fontFile.Name) en el Registry..." -ForegroundColor Cyan
            } else {
                Write-Host "La fuente $($fontFile.Name) ya está registrada en el Registry." -ForegroundColor DarkYellow
            }
        } catch {
            Write-Host "Error al registrar la fuente. ¿Ejecutaste como administrador?" -ForegroundColor Red
        }
    }
}

# Notificar al sistema que las fuentes cambiaron (opcional)
Write-Host "Reinicia las aplicaciones para que las fuentes estén disponibles." -ForegroundColor Magenta