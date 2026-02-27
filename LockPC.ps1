# C# Windows BlockInput API
$code = @"
using System.Runtime.InteropServices;
public class InputBlocker {
    [DllImport("user32.dll")]
    public static extern bool BlockInput(bool fBlockIt);
}
"@
Add-Type -TypeDefinition $code -ErrorAction SilentlyContinue

# Make the window Full Screen
$wshell = New-Object -ComObject wscript.shell
$wshell.SendKeys('%{ENTER}')
Start-Sleep -Milliseconds 500

# 3. Text to display
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
    # 4. Disable keyboard and mouse
    $isBlocked = [InputBlocker]::BlockInput($true)
    
    if (-not $isBlocked) {
        Write-Host "`n[!] WARNING: Mouse/Keyboard NOT blocked. You MUST run PowerShell as Administrator!" -ForegroundColor Red
    }
    Start-Sleep -Seconds 2

    # 6. Stop browsers
    $soft = @("chrome", "msedge", "firefox", "brave", "opera")
    Stop-Process -Name $soft -Force -ErrorAction SilentlyContinue

    # 7. Lock PC
    rundll32.exe user32.dll,LockWorkStation
}
finally {
    # 8. Re-enable keyboard and mouse
    [InputBlocker]::BlockInput($false) | Out-Null
}
