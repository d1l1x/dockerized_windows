#https://www.petri.com/manage-windows-updates-with-powershell-module
Write-Output "Install Windows Updates"
# Evtl. für ältere Windows Versionen wichtig
#   [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

try {
    Write-Output "Installing Nuget"
    Get-PackageProvider -Name "Nuget" -ForceBootstrap -Verbose -ErrorAction Stop
}
catch {
    Write-Output "Installation of nuget failed, exiting"\research\poc\os-source\win\-\issues
    exit(1)
}

try {
    Write-Output "Install PSWindowsUpdate"
    Install-Module PSWindowsUpdate -Force -Confirm:$false -Verbose -ErrorAction Stop
    Import-Module PSWindowsUpdate
}
catch {
    Write-Output "Installation of PSWindowsUpdate failed, exiting"
    exit (1)
}

try {
    Write-Output "Updates pass started"
    Install-WindowsUpdate -AcceptAll -IgnoreReboot -ErrorAction SilentlyContinue
    Write-Output "Updates pass completed"
}
catch {
    Write-Output "Updates pass failed, not critical"
    exit (0)
}

Write-Output "Finished Windows Updates"
exit 0
