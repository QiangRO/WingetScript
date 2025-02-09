$scriptPath = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent 

$fontDirectories = @(
    (Join-Path -Path $scriptPath -ChildPath "Hack"),
    (Join-Path -Path $scriptPath -ChildPath "FiraCode")
)

# Asegurar que la carpeta de destino exista
$fontsFolderPath = "$env:LOCALAPPDATA\Microsoft\Windows\Fonts"
if (-Not (Test-Path -Path $fontsFolderPath)) {
    New-Item -Path $fontsFolderPath -ItemType Directory -Force
}

foreach ($sourcePath in $fontDirectories) {
    $fontFiles = Get-ChildItem -Path $sourcePath -Filter *.ttf

    foreach ($fontFile in $fontFiles) {
        $destinationPath = "$fontsFolderPath\$($fontFile.Name)"

        if (-Not (Test-Path -Path $destinationPath)) {
            Write-Host "Instalando $($fontFile.FullName)..." -ForegroundColor Green
            Copy-Item -Path $fontFile.FullName -Destination $destinationPath -Force

            Add-Type -TypeDefinition @"
            using System;
            using System.Runtime.InteropServices;
            public class FontInstaller {
                [DllImport("gdi32.dll", CharSet = CharSet.Auto)]
                public static extern int AddFontResource(string lpFileName);
            }
"@
            [FontInstaller]::AddFontResource($destinationPath)
        } else {
            Write-Host "La fuente $($fontFile.Name) ya se encuentra instalada." -ForegroundColor Yellow
        }
    }
}

Write-Host "El proceso de instalación de fuentes ha finalizado." -ForegroundColor DarkGray
