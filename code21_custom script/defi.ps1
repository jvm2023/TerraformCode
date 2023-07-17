Import-Module servermanager
add-windowsfeature web-server -includeallsubfeature
add-windowsfeature web-asp-Net45
add-windowsfeature NET-Framework-Features
Set-Content -path "C:\inetpub\wwwroot\Default.html" -Value "customscriptextensiondemo"

