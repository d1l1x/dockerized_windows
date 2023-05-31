Write-Output "Download Norgate Data Updater"
(New-Object System.Net.WebClient).DownloadFile("https://norgatedata.com/downloads/ndu.4.2.1.55.setup.exe", 'C:\Windows\Temp\norgate.exe')
Write-Output "Download finished"
Write-Output "Install Norgate Data Updater"
# cmd /c C:\Windows\Temp\norgate.exe /S /qn

  cmd /c ""C:\PROGRA~1\7-Zip\7z.exe" x C:\Windows\Temp\norgate.exe -oC:\Users\Desktop\norgate"
# https://stackoverflow.com/questions/32713075/exe-silent-installation
# $pathvargs = {C:\Temp\UpgradeClientInstaller\setup.exe /S /v/qn }
# Invoke-Command -ScriptBlock $pathvargs
