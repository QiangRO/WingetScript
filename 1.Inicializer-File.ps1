##########################################################################################################
#                                    ADMINISTRADOR PERMISSIONS REQUIRED                                  #
#                                                                                                        #
#  File that will initialize the scripts and create new powershell instances.                            #
#                                                                                                        #
#     * TestExecute-Functions.                                                                           #
#     * Main.                                                                                            #
#     * Initial-Function                                                                                 #
#     * Start-SecondScript                                                                               #
#                                                                                                        #
##########################################################################################################

param (
    [string[]]$FunctionNames
)

#Ruta directorio padre
$scriptPath = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent

#Rutas archivos
$First = Join-Path -Path $scriptPath -ChildPath "1.Inicializer-File.ps1"
$Second = Join-Path -Path $scriptPath -ChildPath "2.Script-Profile.ps1"

function Write-Message {
    Write-Host "Ejecutando el primer script" -ForegroundColor Cyan
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

function Initial-Function{
    winget upgrade -e --id Microsoft.AppInstaller

    winget install -e --id JanDeDobbeleer.OhMyPosh -s winget

    winget install -e --id Microsoft.PowerShell

    winget install -e --id Microsoft.WindowsTerminal

    winget settings
}

function Start-SecondScript{
    Start-Process pwsh -ArgumentList "-NoExit", "-Command", "& { . '$Second' }"
}

#'Initial-Function',
function Main {
    Write-Message
    Start-Process pwsh -ArgumentList "-NoExit", "-Command", "& { . '$First' -FunctionNames 'Start-SecondScript'}"
}

if ($FunctionNames) {
    TestExecute-Functions
} else {
    Main
}