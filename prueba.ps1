param (
    [string[]]$FunctionNames
)

$scriptPath = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
$scriptIdProgramPath = Join-Path -Path $scriptPath -ChildPath "ProgramasId.ps1"

function Write-Message {
    Write-Host "Hola $scriptPath" -ForegroundColor Cyan
    Write-Host "Hola $scriptPath2" -ForegroundColor Cyan
    Write-Host "Hola $scriptIdProgramPath" -ForegroundColor Cyan
}

function Write-Message2 {
    Write-Host "Mundo" -ForegroundColor Cyan
}

function Test-Functions {
    foreach ($FunctionName in $FunctionNames) {
        if (Get-Command -Name $FunctionName -ErrorAction SilentlyContinue) {
            & $FunctionName
        } else {
            Write-Host "La función '$FunctionName' no existe." -ForegroundColor Red
        }
    }
}

function Main {
    Write-Message
    Start-Process pwsh -ArgumentList "-NoExit", "-Command", "& { . '$scriptPath\prueba.ps1' -FunctionNames 'Write-Message2', 'Write-Message' }"
}

if ($FunctionNames) {
    Test-Functions
} else {
    Main
}