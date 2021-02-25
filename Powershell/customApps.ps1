# Parameters

# Function
function MyServer {
    # Login to $ServerIP as $ServerUser
    # $args commands will be operated if being provided
    Write-Output "ssh -l $ServerUser $ServerIP $args"
    ssh -l $ServerUser $ServerIP $args
}

function Start-Bgd-Job {
    # Start background job
    if ($args.length -eq 0) {
        Write-Output 'Recommand gramma:'
        Write-Output 'Start-Bgd-Job -jupyter'
    }

    # Start jupyter as background job
    if ($args -eq "-jupyter") {
        Write-Output 'Starting juptyerlab'
        Start-Job -ScriptBlock { Set-Location $using:pwd; jupyter-lab.exe . }
    }
}

function Remove-All-Jobs {
    # Remove all jobs by force
    # It means kill the job and remove it from the pool
    Write-Output 'Before:'
    Get-Job
    Get-Job | Select-Object id | Remove-Job -Force
    Write-Output 'After:'
    Get-Job
}

function Find-Files-By ($ext, $depth) {
    # Find all the files ends with $ext
    if ($ext.length -eq 0) {
        Write-Output 'Find all the files ends with $ext, $depth'
        Write-Output 'Please provide the extension to find them'
    }
    else {
        Get-ChildItem -depth $depth -Recurse | Sort-Object LastAccessTime | Where-Object { $_.Extension -eq $ext } | Select-Object LastAccessTime, FullName
    }
}

function Invoke-CapsLockPlus () {
    # Invoke CapsLockPlus
    # I assume the software has been installed on the ~/Documents/capslock-plus
    Invoke-Command -ScriptBlock { set-location $env:HOME\Documents\capslock-plus; .\CapsLock+.ahk }
}

Write-Output 'Custom Apps have been loaded.'