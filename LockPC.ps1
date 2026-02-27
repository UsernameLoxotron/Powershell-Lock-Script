# Stop browsers, or any other software
$soft = @("chrome", "msedge", "firefox", "brave", "opera")
Stop-Process -Name $soft -Force -ErrorAction SilentlyContinue

# Lock PC
rundll32.exe user32.dll,LockWorkStation