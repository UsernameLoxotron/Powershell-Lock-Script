# C# Windows BlockInput API
$signature = @"
[DllImport("user32.dll", CharSet=CharSet.Auto, ExactSpelling=true)]
public static extern bool BlockInput(bool fBlockIt);
"@
$BlockInput = Add-Type -MemberDefinition $signature -Name "InputBlocker" -Namespace "Win32" -PassThru

# Text to display
$asciiArt = @"
                                .oodMMMM
                       .oodMMMMMMMMMMMMM
           ..oodMMM  MMMMMMMMMMMMMMMMMMM
     oodMMMMMMMMMMM  MMMMMMMMMMMMMMMMMMM
     MMMMMMMMMMMMMM  MMMMMMMMMMM…M
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
Write-Host "`nLocking workstation and closing browsers in 5 seconds..." -ForegroundColor Yellow

try {
    # Disable keyboard and mouse
    $BlockInput::BlockInput($true) | Out-Null

    Start-Sleep -Seconds 5

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
