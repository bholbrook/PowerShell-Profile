
$sessionStartDateTime = Get-Date -Format "ddMMyy_hhmmss"

if (-not (Test-Path "C:\Transcripts")) {
    New-Item "C:\Transcripts" -Type Directory | Out-Null
}
Start-Transcript "C:\Transcripts\$sessionStartDateTime.txt"

function Show-BalloonTip {

    [CmdletBinding()]
    Param (
        [Parameter(Position=1, Mandatory=$true)] [string] $Title,
        [Parameter(Position=2, Mandatory=$true)] [string] $Message,
        [Parameter(Position=3, Mandatory=$false)] [ValidateSet("Info","Warning","Error")] [string] $MessageType = "Info",
        [Parameter(Position=4, Mandatory=$false)] [string] $Duration = 2000
    )

    Add-Type -AssemblyName System.Windows.Forms
    Add-Type -AssemblyName System.Drawing

    $balloon = New-Object System.Windows.Forms.NotifyIcon
    $path = Get-Process -Id $pid | Select-Object -ExpandProperty Path
    $icon = [System.Drawing.Icon]::ExtractAssociatedIcon($path)
    $balloon.Icon = $icon
    $balloon.BalloonTipIcon = $MessageType
    $balloon.BalloonTipText = $Message
    $balloon.BalloonTipTitle = $Title
    $balloon.Visible = $true
    $balloon.ShowBalloonTip($Duration)
}

function New {

    Param (
        [Parameter(Position=1, Mandatory=$true)] [string] $Name,
        [switch] [Alias("Dir")] $Directory
    )

    if ($Directory) {
        New-Item -Type Directory $Name
    }
    else {    
        New-Item -Type File $Name
    }
}

function Edit {

    Param (
        [Parameter(Position=1, Mandatory=$true)] [string] $Name
    )

    notepad.exe $Name
}

function Skydrive {
    cd "D:\Skydrive"
}

function GDrive {
    cd "D:\SkyDrive\Google Drive"
}

function Catan {
    cd "D:\Skydrive\Powershell\Catan"
}

Set-Alias -Name sd Skydrive
Set-Alias -Name gd GDrive
Set-Alias -Name nf New