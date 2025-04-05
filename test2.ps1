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
function Write-Message {
    $scriptPath = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
    $scriptToRun = Join-Path -Path $scriptPath -ChildPath "test2.ps1"
    Write-Host "Ejecutando el orquestador 1.Inicializer-File.ps1 como administrador." -ForegroundColor Cyan
    Write-Host "scriptPath $scriptPath" -ForegroundColor Cyan
    Write-Host "scriptToRun $scriptToRun" -ForegroundColor Cyan
}

function Main{
    
}

if ($FunctionNames) {
    TestExecute-Functions
} else {
    Main
}