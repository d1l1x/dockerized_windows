if (!( Test-Path "C:\Windows\Temp\7z2201-x64.msi")) {
  [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; (New-Object System.Net.WebClient).DownloadFile('https://www.7-zip.org/a/7z2201-x64.msi', 'C:\Windows\Temp\7z2201-x64.msi')
}
if (!(Test-Path "C:\Windows\Temp\7z2201-x64.msi")) {
  Start-Sleep 5; [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; (New-Object System.Net.WebClient).DownloadFile('https://www.7-zip.org/a/7z2201-x64.msi', 'C:\Windows\Temp\7z2201-x64.msi')
}
cmd /c msiexec /qb /i C:\Windows\Temp\7z2201-x64.msi