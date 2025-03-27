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

#Rutas
$scriptPath = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
$Second = Join-Path -Path $scriptPath -ChildPath "2.Script-Profile.ps1"

function Write-Message {
    Write-Host "Ejecutando el primer script, llamando al segundo script" -ForegroundColor Cyan
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

#'Initial-Function',
function Main {
    Start-Process pwsh -ArgumentList "-NoExit", "-Command", "& { . '$Second' -FunctionNames 'Start-AllProfileFunctions' }"
}

if ($FunctionNames) {
    TestExecute-Functions
} else {
    Main
}