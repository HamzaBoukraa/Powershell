[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12;
<# 4.6.2 : #>
Invoke-WebRequest 'https://download.microsoft.com/download/E/F/D/EFD52638-B804-4865-BB57-47F4B9C80269/NDP462-DevPack-KB3151934-ENU.exe' -OutFile 'dotnet-install.exe';
<# 4.7.1 :
Invoke-WebRequest 'https://download.microsoft.com/download/9/0/1/901B684B-659E-4CBD-BEC8-B3F06967C2E7/NDP471-DevPack-ENU.exe' -OutFile 'dotnet-install.exe';
#>
Start-Process dotnet-install.exe -Wait -ArgumentList '/install /quiet /log dotnetinstall.log';
