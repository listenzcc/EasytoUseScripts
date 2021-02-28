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

function Remove-Bgd-Jobs {
    # Remove all jobs by force
    # It means kill the job and remove it from the pool
    Write-Output 'Before:'
    Get-Job
    Get-Job | Select-Object id | Remove-Job -Force
    Write-Output 'After:'
    Get-Job
}

function Find-Files-By ($ext, $depth, $combine) {
    # Find all the files ends with $ext
    # if not provide $depth,
    # we will use 3 for instead.

    if ($depth.length -eq 0) {
        $depth = 3
    }

    if ($ext.length -eq 0) {
        Write-Output 'Invalid input, Example input is "Find-Files-By $ext[, $depth]"'
    }
    else {
        if ($combine -eq 0) {
            Get-ChildItem -depth $depth -Recurse | Where-Object { $_.Extension -eq $ext } | Sort-Object FullName
        }
        else {
            Get-ChildItem -depth $depth -Recurse | Where-Object { $_.Extension -eq $ext } | Sort-Object FullName | Select-Object LastWriteTime, fullname
        }
    }
}

function Invoke-CapsLockPlus () {
    # Invoke CapsLockPlus
    # I assume the software has been installed on the ~/Documents/capslock-plus
    Invoke-Command -ScriptBlock { set-location $env:HOME\Documents\capslock-plus; .\CapsLock+.ahk }
}

function MyFunctions() {
    # List all my custom functions
    Write-Output "MyServer            `t: Access to my Server Quickly"
    Write-Output "Start-Bgd-job       `t: Start Background Job"
    Write-Output "Remove-Bgd-Jobs     `t: Remove All Background Jobs"
    Write-Output "Find-Files-By       `t: Find Subfiles with their Extensions"
    write-Output "Invoke-CapsLockPlus `t: Invoke CapsLockPlus"
}

Write-Output 'Custom Apps have been loaded, type "MyFunctions" to see them.'