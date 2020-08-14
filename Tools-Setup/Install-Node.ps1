Invoke-WebRequest -Uri https://nodejs.org/dist/v14.8.0/node-v14.8.0-x64.msi -OutFile .\node.msi;
Start-Process msiexec.exe -Wait -ArgumentList '/I node.msi';
rm .\node.msi;
