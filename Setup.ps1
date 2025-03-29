param (
    [string[]]$FunctionNames
)
#Ruta directorio padre
$scriptPath = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
$First = Join-Path -Path $scriptPath -ChildPath "1.Inicializer-File.ps1"

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
    Write-Host "Llamando al primer script" -ForegroundColor Cyan
    Start-Process pwsh -ArgumentList "-NoExit", "-Command", "& { . '$First' -FunctionNames 'Initial-Function' }"
}

if ($FunctionNames) {
    Test-Functions
} else {
    Main
}
