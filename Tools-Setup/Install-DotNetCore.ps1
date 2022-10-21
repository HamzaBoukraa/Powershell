[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12;
$WebClient = New-Object Net.WebClient;
$WebClient.DownloadFile("https://dot.net/v1/dotnet-install.ps1", ".\dotnet-install.ps1");
# Invoke-WebRequest 'https://dot.net/v1/dotnet-install.ps1' -OutFile ".\dotnet-install.ps1";
./dotnet-install.ps1;
