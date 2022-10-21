$WebClient = New-Object Net.WebClient;
$WebClient.DownloadFile("https://aka.ms/installazurecliwindows", ".\AzureCLI.msi");
# Invoke-WebRequest -Uri https://aka.ms/installazurecliwindows -OutFile .\AzureCLI.msi;
Start-Process msiexec.exe -Wait -ArgumentList '/I AzureCLI.msi /quiet';
rm .\AzureCLI.msi;
