param (
    [string[]]$FunctionNames
)

# $scriptPath = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
# $scriptToRun = Join-Path -Path $scriptPath -ChildPath "1.Inicializer-File.ps1"
# Write-Host "Ejecutando el orquestador 1.Inicializer-File.ps1 como administrador." -ForegroundColor Cyan
# Start-Process powershell.exe -Verb RunAs -ArgumentList "-NoExit", "-ExecutionPolicy Bypass", "-Command", "& { . '$scriptToRun' -FunctionNames 'Inicializer-Function'}"

function Reload-Script {
    param (
        [string]$scriptToRun = "$PSScriptRoot\1.Inicializer-File.ps1",
        [string[]]$FunctionNames = @("Inicializer-Function")
    )

    $fnParams = $FunctionNames -join ' '

    Write-Host "Reiniciando el script como administrador..." -ForegroundColor Cyan
    Start-Process powershell.exe -Verb RunAs -ArgumentList "-ExecutionPolicy Bypass -File `"$scriptToRun`" -FunctionNames $fnParams"

    Stop-Process -Id $PID
}


function TestExecute-Functions {
    foreach ($FunctionName in $FunctionNames) {
        if (Get-Command -Name $FunctionName -ErrorAction SilentlyContinue) {
            & $FunctionName
        } else {
            Write-Host "La función '$FunctionName' no existe." -ForegroundColor Red
        }
    }
}

function Is-PwshInstalled {
    return (Get-Command pwsh -ErrorAction SilentlyContinue) -ne $null
}

function Is-WingetVersionOK {
    try {
        $rawVersion = & winget --version
        $version = [version]$rawVersion.TrimStart("v")  # Quita "v" si está
        return ($version -ge [version]"1.10.0")
    } catch {
        return $false
    }
}

function Install-FirstPrograms {
    $pwshWasInstalled = Is-PwshInstalled
    $wingetWasAvailable = Is-WingetVersionOK

    Write-Host "pwshWasInstalled $pwshWasInstalled" -ForegroundColor Cyan
    Write-Host "wingetWasAvailable $wingetWasAvailable" -ForegroundColor Cyan
    Write-Host "Actualizando App Installer..." -ForegroundColor Cyan
    winget upgrade -e --id Microsoft.AppInstaller

    Write-Host "Instalando PowerShell 7..." -ForegroundColor Cyan
    winget install -e --id Microsoft.PowerShell

    # Comprobar si ahora están disponibles
    #NO REINICIA!!
    $pwshNowInstalled = Is-PwshInstalled
    $wingetNowAvailable = Is-WingetVersionOK

    if (-not $pwshWasInstalled -and $pwshNowInstalled) {
        Write-Host "PowerShell 7 fue instalado. Reiniciando..." -ForegroundColor Yellow
        Reload-Script
    }

    if (-not $wingetWasAvailable -and $wingetNowAvailable) {
        Write-Host "Winget fue instalado. Reiniciando..." -ForegroundColor Yellow
        Reload-Script
    }

    Write-Host "Primera instalación finalizada." -ForegroundColor Green
}

if ($FunctionNames) {
    TestExecute-Functions
} else {
    Main
}