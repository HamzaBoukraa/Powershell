$JavaSetupFileUrl = (Invoke-WebRequest -UseBasicParsing https://www.java.com/en/download/manual.jsp).Content | %{[regex]::matches($_, '(?:<a title="Download Java software for Windows Online" href=")(.*)(?:">)').Groups[1].Value}
Invoke-WebRequest -UseBasicParsing -OutFile jre.exe $JavaSetupFileUrl
Start-Process .\jre.exe '/s REBOOT=0 SPONSORS=0 AUTO_UPDATE=0' -wait
echo $?
