##########################################################################################################
#                                    ADMINISTRADOR PERMISSIONS REQUIRED                                  #
#                                                                                                        #
#  File that will initialize the scripts and create new powershell instances.                            #
#                                                                                                        #
#     * Test-Functions.                                                                                  #
#     * Main.                                                                                            #
#                                                                                                        #
##########################################################################################################
param (
    [string[]]$FunctionNames
)
#Ruta directorio padre
$scriptPath = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent

#Rutas archivos
$First = Join-Path -Path $scriptPath -ChildPath "1.Script-Initial"
$Second = Join-Path -Path $scriptPath -ChildPath "2.Script-Profile.ps11"
$Third = Join-Path -Path $scriptPath -ChildPath "3.Script-Copyfiles.ps1"

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
    Start-Process pwsh -ArgumentList "-NoExit", "-Command", "& { . '$First' -FunctionNames 'Initial-Function' }"

    Start-Process pwsh -ArgumentList "-NoExit", "-Command", "& { . '$Second' -FunctionNames 'Start-ScriptInstall', 'Start-ScriptDownload', 'Start-ScriptDelete', 'Start-ScriptUpdate', 'Start-ScriptAdd', 'Start-ScriptShow'}"

    Start-Process pwsh -ArgumentList "-NoExit", "-Command", "& { . '$Third' -FunctionNames 'Start-InstallFonts', 'Start-CopyOhMyPosh', 'Start-CopyTerminalSettings', 'Start-CopyWingetSettings'}"
}

if ($FunctionNames) {
    Test-Functions
} else {
    Main
}