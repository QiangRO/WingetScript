param (
    [string[]]$FunctionNames
)

# $scriptPath = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
# $scriptToRun = Join-Path -Path $scriptPath -ChildPath "1.Inicializer-File.ps1"
# Write-Host "Ejecutando el orquestador 1.Inicializer-File.ps1 como administrador." -ForegroundColor Cyan
# Start-Process powershell.exe -Verb RunAs -ArgumentList "-NoExit", "-ExecutionPolicy Bypass", "-Command", "& { . '$scriptToRun' -FunctionNames 'Inicializer-Function'}"

function TestExecute-Functions {
    foreach ($FunctionName in $FunctionNames) {
        if (Get-Command -Name $FunctionName -ErrorAction SilentlyContinue) {
            & $FunctionName
        } else {
            Write-Host "La función '$FunctionName' no existe." -ForegroundColor Red
        }
    }
}

function test-dependencies{
    #return (Get-Command dotnet -ErrorAction SilentlyContinue) -ne $null

    # if (-Not (winget list --id Microsoft.VisualStudioCode)) { #SI VERIFICA
    #     Write-Host "Instalando" -ForegroundColor DarkBlue
    # }
    # else {
    #     Write-Host "Ya está instalado." -ForegroundColor Green
    # }

    # $DotNet8Installed = $dotnetSdks -match '^8\.\d+'
    # Write-Host "$DotNet8Installed" -ForegroundColor Green
    # $DotNetPreviewInstalled = $dotnetSdks -match 'preview'
    # Write-Host "$DotNetPreviewInstalled" -ForegroundColor Green

    # if (-not (winget install -e --id Rufus.Rufus)) {
    #     Write-Host "Error al instalar." -ForegroundColor Red
    #     return $false
    # }
    # Write-Host "Instalado correctamente" -ForegroundColor Green

    # $downloadsPath = [System.IO.Path]::Combine($env:USERPROFILE, 'Downloads')
    # Write-Host "downloadsPath $downloadsPath" -ForegroundColor Green

    
    # Write-Host "programFiles $programFiles" -ForegroundColor Green

    
    # Write-Host "programFilesX86 $programFilesX86" -ForegroundColor Green
    
    $profileDirectory = Split-Path -Path $PROFILE
    Write-Host "profileDirectory $profileDirectory" -ForegroundColor Green

    $scriptPath = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
    Write-Host "scriptPath $scriptPath" -ForegroundColor Green

    Write-Host "$MyInvocation.MyCommand.Definition"
}

function Write-Message {

}

function Main{
    
}

if ($FunctionNames) {
    TestExecute-Functions
} else {
    Main
}