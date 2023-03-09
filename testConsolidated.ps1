# # Download the SQL Server Express installer
Invoke-WebRequest -Uri "https://go.microsoft.com/fwlink/?linkid=853016" -OutFile "C:\Users\Administrator\Downloads\SQLEXPR_x64_ENU.exe"
C:\Users\Administrator\Downloads\SQLEXPR_x64_ENU.exe /ENU /Action=Download /MediaPath=C:\Users\Administrator\Downloads\mssql_setup\media /MediaType=ISO /quiet 

# # Install Visual Studio Code
Invoke-WebRequest -Uri "https://code.visualstudio.com/sha/download?build=stable&os=win32-x64-user" -OutFile "C:\Users\Administrator\Downloads\vscode-setup.exe"
Start-Process "C:\Users\Administrator\Downloads\vscode-setup.exe" -ArgumentList "/NORESTART", "/silent", "/mergetasks=!runcode" -Wait

# # Install Postman
Invoke-WebRequest -Uri "https://dl.pstmn.io/download/latest/win64" -OutFile "C:\Users\Administrator\Downloads\postman.exe"
Start-Process "C:\Users\Administrator\Downloads\postman.exe" -ArgumentList "/S","/silent" -Wait -NoNewWindow -PassThru

# # Install Notepad++
Invoke-WebRequest -Uri "https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v8.4.9/npp.8.4.9.Installer.x64.exe" -OutFile "C:\Users\Administrator\Downloads\npp-setup.exe"
Start-Process "C:\Users\Administrator\Downloads\npp-setup.exe" -ArgumentList "/S" -Wait -NoNewWindow -PassThru

# # Install Visual Studio
Invoke-WebRequest -Uri " https://c2rsetup.officeapps.live.com/c2r/downloadVS.aspx?sku=community&channel=Release&version=VS2022&source=VSLandingPage&includeRecommended=true&cid=2030" -OutFile "C:\Users\Administrator\Downloads\vs-setup.exe"
Start-Process -FilePath 'C:\Users\Administrator\Downloads\vs-setup.exe' -ArgumentList "--installPath", "C:\Program Files\Microsoft\Visual Studio\2022\Enterprise", "--passive", "--wait" -Wait -PassThru -NoNewWindow


# # Download the SSMS installer
Invoke-WebRequest -Uri "https://aka.ms/ssmsfullsetup" -OutFile "C:\Users\Administrator\Downloads\SSMS-Setup-ENU.exe"

# # Install SSMS
Start-Process "C:\Users\Administrator\Downloads\SSMS-Setup-ENU.exe" -ArgumentList "/install /quiet /norestart" -Wait





New-Item -Path C:\Users\Administrator\Downloads\SQLexpress -ItemType Directory
$mountResult = Mount-DiskImage -ImagePath 'C:\Users\Administrator\Downloads\mssql_setup\media\SQLServer2017-x64-ENU-Dev.iso' -PassThru
$volumeInfo = $mountResult | Get-Volume
$driveInfo = Get-PSDrive -Name $volumeInfo.DriveLetter
Copy-Item -Path ( Join-Path -Path $driveInfo.Root -ChildPath '*' ) -Destination C:\Users\Administrator\Downloads\SQLexpress\ -Recurse
Dismount-DiskImage -ImagePath 'C:\Users\Administrator\Downloads\mssql_setup\media\SQLServer2017-x64-ENU-Dev.iso'



#change this to the location of your configuration file
$configfile = Join-Path $PSScriptRoot "ConfigurationFile.ini"

#we are still using the setup.exe that comes with
#the SQL Server bits
#adjust the path below to where your setup.exe is
$command = "C:\Users\Administrator\Downloads\SQLexpress\setup.exe /ConfigurationFile=$($configfile)"
#run the command
Invoke-Expression -Command $command
