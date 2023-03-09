
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
