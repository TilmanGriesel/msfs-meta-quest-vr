# Default config
$DEFAULT_OCULUS_TOOL = "C:\Program Files\Oculus\Support\oculus-diagnostics\OculusDebugToolCLI.exe"
$DEFAULT_LOG_FILE = ".\config\odt-config-default.txt"
$DEFAULT_QRES_TOOL = ".\bin\QRes.exe"
$DEFAULT_VR_RESOLUTION = "800x600"
$DEFAULT_DEFAULT_RESOLUTION = "3440x1440" # WQHD Ultrawide

# Help
function Show-Usage {
    Write-Host "Usage: $($MyInvocation.MyCommand.Name) [options]"
    Write-Host "Options:"
    Write-Host "  -o, --oculus-tool <path>      Path to OculusDebugToolCLI.exe (default: $DEFAULT_OCULUS_TOOL)"
    Write-Host "  -l, --log-file <path>         Path to log file (default: $DEFAULT_LOG_FILE)"
    Write-Host "  -q, --qres-tool <path>        Path to QRes.exe (default: $DEFAULT_QRES_TOOL)"
    Write-Host "  -v, --vr-resolution <res>     VR resolution (default: $DEFAULT_VR_RESOLUTION)"
    Write-Host "  -d, --default-resolution <res> Default resolution (default: $DEFAULT_DEFAULT_RESOLUTION)"
    Write-Host "  -h, --help                    Show this help message and exit"
    exit 1
}

# Arguments
$OCULUS_TOOL = $DEFAULT_OCULUS_TOOL
$LOG_FILE = $DEFAULT_LOG_FILE
$QRES_TOOL = $DEFAULT_QRES_TOOL
$VR_RESOLUTION = $DEFAULT_VR_RESOLUTION
$DEFAULT_RESOLUTION = $DEFAULT_DEFAULT_RESOLUTION

$i = 0
while ($i -lt $args.Count) {
    $arg = $args[$i]
    switch ($arg) {
        '-o' { 
            $i++
            if ($i -lt $args.Count) {
                $OCULUS_TOOL = $args[$i]; 
            } else {
                Write-Host "Option $arg requires an argument."
                Show-Usage
            }
        }
        '--oculus-tool' {
            $i++
            if ($i -lt $args.Count) {
                $OCULUS_TOOL = $args[$i]; 
            } else {
                Write-Host "Option $arg requires an argument."
                Show-Usage
            }
        }
        '-l' {
            $i++
            if ($i -lt $args.Count) {
                $LOG_FILE = $args[$i]; 
            } else {
                Write-Host "Option $arg requires an argument."
                Show-Usage
            }
        }
        '--log-file' {
            $i++
            if ($i -lt $args.Count) {
                $LOG_FILE = $args[$i]; 
            } else {
                Write-Host "Option $arg requires an argument."
                Show-Usage
            }
        }
        '-q' {
            $i++
            if ($i -lt $args.Count) {
                $QRES_TOOL = $args[$i]; 
            } else {
                Write-Host "Option $arg requires an argument."
                Show-Usage
            }
        }
        '--qres-tool' {
            $i++
            if ($i -lt $args.Count) {
                $QRES_TOOL = $args[$i]; 
            } else {
                Write-Host "Option $arg requires an argument."
                Show-Usage
            }
        }
        '-v' {
            $i++
            if ($i -lt $args.Count) {
                $VR_RESOLUTION = $args[$i]; 
            } else {
                Write-Host "Option $arg requires an argument."
                Show-Usage
            }
        }
        '--vr-resolution' {
            $i++
            if ($i -lt $args.Count) {
                $VR_RESOLUTION = $args[$i]; 
            } else {
                Write-Host "Option $arg requires an argument."
                Show-Usage
            }
        }
        '-d' {
            $i++
            if ($i -lt $args.Count) {
                $DEFAULT_RESOLUTION = $args[$i]; 
            } else {
                Write-Host "Option $arg requires an argument."
                Show-Usage
            }
        }
        '--default-resolution' {
            $i++
            if ($i -lt $args.Count) {
                $DEFAULT_RESOLUTION = $args[$i]; 
            } else {
                Write-Host "Option $arg requires an argument."
                Show-Usage
            }
        }
        '-h' {
            Show-Usage
        }
        '--help' {
            Show-Usage
        }
        default {
            Write-Host "Unknown option: $arg"
            Show-Usage
        }
    }
    $i++
}

# Functions
function Set-Resolution {
    param (
        [string]$resolution
    )
    $width, $height = $resolution -split 'x'
    Write-Host "[DEBUG] Command: $QRES_TOOL /x:$width /y:$height"
    & $QRES_TOOL "/x:$width" "/y:$height"
    $status = $LASTEXITCODE
    if ($status -eq 0) {
        Write-Host "Resolution successfully set to ${width}x${height}."
    } else {
        Write-Host "Failed to set resolution. QRes returned exit code $status."
        Write-Host "Please ensure QRes is properly configured and the syntax is correct."
    }
}

function Start-VRSession {
    Write-Host "Starting VR session..."
    Write-Host "[DEBUG] Command: `"$OCULUS_TOOL`" -f `"$LOG_FILE`""
    & $OCULUS_TOOL "-f" $LOG_FILE
    Set-Resolution $VR_RESOLUTION
}

function End-VRSession {
    Write-Host "Ending VR session..."
    Set-Resolution $DEFAULT_RESOLUTION
}

# Main
Clear-Host
Write-Host "VR Session Manager"
Write-Host "Press any key to end the VR session and restore the resolution."

Start-VRSession

while ($true) {
    Start-Sleep -Milliseconds 1000
    if ($Host.UI.RawUI.KeyAvailable) {
        $key = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
        Write-Host
        Write-Host "Key pressed. Exiting VR session..."
        End-VRSession
        break
    }
}

Write-Host "Resolution restored to $DEFAULT_RESOLUTION. Exiting..."
exit 0
