# Parameters

# Function
function MyServer {
    # Login to $ServerIP as $ServerUser
    # $args commands will be operated if being provided
    [cmdletBinding()]
    param (
        $User = $serverUser
        , $Ip = $serverIP
        , $Cmd
    )
    Write-Output "ssh -l $User $Ip $Cmd"
    ssh -l $User $Ip $Cmd
}

function Start-Bgd-Job {
    # Start background job
    [cmdletBinding()]
    param(
        $Method
    )

    # Start jupyter as background job
    if ($Method -eq "jupyter") {
        Write-Output 'Starting juptyerlab'
        Start-Job -ScriptBlock { Set-Location $using:pwd; jupyter-lab.exe . }
    }
}

function Remove-Bgd-Jobs {
    # Remove all jobs by force
    # It means kill the job and remove it from the pool
    # Show State Before Remove
    Write-Output 'Before:'
    Get-Job
    # Remove jobs
    Get-Job | Select-Object id | Remove-Job -Force
    # Show State After Remove
    Write-Output 'After:'
    Get-Job
}

function Find-Files-By {
    # Find all the files ends with $ext
    # if not provide $depth,
    # we will use 3 for instead.
    [CmdletBinding()]
    param(
        $Ext = ".txt"
        , $Depth = 1
    )

    Write-Output "----  Finding $Ext files with Depth of $Depth ----"

    Get-ChildItem -Depth $depth -Recurse | Where-Object { $_.Extension -eq $ext } | Sort-Object FullName
}

function Invoke-CapsLockPlus () {
    # Invoke CapsLockPlus
    # I assume the software has been installed on the ~/Documents/capslock-plus
    Invoke-Command -ScriptBlock { set-location $env:HOME\Documents\capslock-plus; .\CapsLock+.ahk }
}

function Get-ChildItem-MyEnhance {
    # Enhancement of Get-ChildItem method
    # It will produce "MegaByte" and "RelativeName" properties for Get-ChildItem
    [CmdletBinding()]
    param(
        $Path = $pwd.path
        , $Depth = 0
        , $Exclude = ""
        , [switch]$Recurse
    )

    $gc = Get-ChildItem -Path $Path -Depth $Depth -Recurse

    $gc | Select-Object Mode, LastWriteTime, FileSize, @{Name = "RelativeName"; Expression = { (resolve-path -relative $_.fullname).Replace(".\", "") } }
}

function Set-Location-MyEnhance {
    # Require,
    # module: cd-extras

    [CmdletBinding()]
    param(
        # Default $Path
        $Path = '~'
    )

    # CD to $Path and prompt
    Set-LocationEx $Path
    $path = $pwd.path
    write-output "Changed location to $path"

    # Append the $path,
    # into the END of the file
    $path >> $env:HOME/.cd-trace
}


function Get-LocationTrace {
    # Require,
    # module: cd-extras

    # Get trace history
    $lst = Get-Content $env:HOME/.cd-trace
    # Reverse the trace
    [array]::Reverse($lst)
    # Remove the duplicated rows,
    # the first occurs are kept
    $lst = ($lst | Select-Object -Unique)
    # Reverse back the trace
    [array]::Reverse($lst)
    $lst = ($lst | Select-Object -Last 9)
    # See what we have got
    # write-output $lst $lst.Length
    For ($i = 0; $i -lt $lst.Length; $i++) {
        $j = $lst.Length - $i
        $e = $lst[$i]
        Write-Output "[$j] $e"
    }

    # Interaction
    $select = Read-Host -Prompt 'CD to'
    $path = $lst[$lst.Length - $select]
    Write-Output $path
    Set-Location-MyEnhance $path
}

$ScriptPath = $script:MyInvocation.MyCommand.Path

Set-Item Alias:cd Set-Location-MyEnhance
Set-Alias cdt Get-LocationTrace
Update-TypeData -AppendPath $ScriptPath\\..\\type\\fileTypeEnhance.ps1xml -verbose

function MyFunctions() {
    # The script is
    Write-Output "Script is $ScriptPath"
    # List all my custom functions
    Write-Output "MyServer                `t: Access my Server Quickly"
    Write-Output "Start-Bgd-job           `t: Start Background Job"
    Write-Output "Remove-Bgd-Jobs         `t: Remove All Background Jobs"
    Write-Output "Find-Files-By           `t: Find Subfiles with their Extensions"
    Write-Output "Invoke-CapsLockPlus     `t: Invoke CapsLockPlus"
    Write-Output "Get-ChildItem-MyEnhance `t: List Files with their FileSize"
    Write-Output "Set-Location-MyEnhance  `t: Enhanced cd command, cd and record the pwd after"
    Write-Output "Get-LocationTrace       `t: Enhanced cdt command, list history path and cd to the selected"
}

Write-Output 'Custom Apps have been loaded, type "MyFunctions" to see them.'
