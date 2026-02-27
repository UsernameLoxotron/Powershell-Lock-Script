# Self-elevate to Administrator
$isAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if (-not $isAdmin) {
    Start-Process powershell.exe "-ExecutionPolicy Bypass -WindowStyle Maximized -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

# Full Screen
$wshell = New-Object -ComObject wscript.shell
$wshell.SendKeys('{F11}')
Start-Sleep -Milliseconds 250

# C# Windows BlockInput API
$signature = @"
[DllImport("user32.dll", CharSet=CharSet.Auto, ExactSpelling=true)]
public static extern bool BlockInput(bool fBlockIt);
"@

if (-not ("Win32.InputBlocker" -as [type])) {
    $BlockInput = Add-Type -MemberDefinition $signature -Name "InputBlocker" -Namespace "Win32" -PassThru
} else {
    $BlockInput = [Win32.InputBlocker]
}

# 4. Text to display
$asciiArt = @"
                                .oodMMMM
                       .oodMMMMMMMMMMMMM
           ..oodMMM  MMMMMMMMMMMMMMMMMMM
     oodMMMMMMMMMMM  MMMMMMMMMMMMMMMMMMM
     MMMMMMMMMMMMMM  MMMMMMMMMMM...M
     MMMMMMMMMMMMMM  MMMMMMMMMMMMMMMMMMM
     MMMMMMMMMMMMMM  MMMMMMMMMMMMMMMMMMM
     MMMMMMMMMMMMMM  MMMMMMMMMMMMMMMMMMM
     MMMMMMMMMMMMMM  MMMMMMMMMMMMMMMMMMM
    
     MMMMMMMMMMMMMM  MMMMMMMMMMMMMMMMMMM
     MMMMMMMMMMMMMM  MMMMMMMMMMMMMMMMMMM
     MMMMMMMMMMMMMM  MMMMMMMMMMMMMMMMMMM
     MMMMMMMMMMMMMM  MMMMMMMMMMMMMMMMMMM
     MMMMMMMMMMMMMM  MMMMMMMMMMMMMMMMMMM
     `^^^^^^MMMMMMM  MMMMMMMMMMMMMMMMMMM
           ````^^^^  ^^MMMMMMMMMMMMMMMMM
                         ````^^^^^^MMMM
"@

Clear-Host
Write-Host $asciiArt -ForegroundColor Cyan

try {
    # Disable keyboard and mouse
    $BlockInput::BlockInput($true) | Out-Null
    Start-Sleep -Seconds 2
    # Stop browsers, or any other software
    $soft = @("chrome", "msedge", "firefox", "brave", "opera")
    Stop-Process -Name $soft -Force -ErrorAction SilentlyContinue
    # Lock PC
    rundll32.exe user32.dll,LockWorkStation
}
finally {
    # Enable keyboard and mouse
    $BlockInput::BlockInput($false) | Out-Null
}
