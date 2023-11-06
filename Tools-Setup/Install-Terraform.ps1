param (
  $TerraformPath = "X:\Terraform\"
)

Set-ExecutionPolicy Unrestricted -Scope Process;

Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Internet Explorer\Main" -Name "DisableFirstRunCustomize" -Value 2;

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12;
$WebClient = New-Object Net.WebClient;

$TerraformInPath = $($env:Path).Split(";").Where{$_.ToLower().Contains("terraform")};

if($TerraformInPath.Count -gt 0){
  $TerraformRootPath = $TerraformInPath[0];
}
else {
  $TerraformRootPath = $TerraformPath;
}

if(!(Test-Path $TerraformRootPath)){
	New-Item -Type Directory -Path $TerraformRootPath -Verbose;
}

Set-Location $TerraformRootPath

$TerraformReleasesRootUrl = "https://releases.hashicorp.com"
$TerraformReleasesUrl = "$($TerraformReleasesRootUrl)/terraform"

$TerraformReleasesLatest = (Invoke-WebRequest -Uri $TerraformReleasesUrl).Links.Where{($_.innerText.Contains("terraform_")) -and -not($_.innerText.Contains("rc")) -and -not($_.innerText.Contains("alpha")) -and -not($_.innerText.Contains("beta"))}[0]

$TerraformReleaseLatestUrl = "$($TerraformReleasesRootUrl)$($TerraformReleasesLatest.href)"

$TerraformLatestReleaseDownloadLink = (Invoke-WebRequest -Uri $TerraformReleaseLatestUrl).Links.Where{($_.innerText.Contains("windows_amd64"))}

$FileName = "$($TerraformRootPath)$($TerraformLatestReleaseDownloadLink.innerText)";

$WebClient.DownloadFile($TerraformLatestReleaseDownloadLink.href, $FileName);

# Invoke-WebRequest -Uri $TerraformLatestReleaseDownloadLink.href -OutFile $TerraformLatestReleaseDownloadLink.innerText

Get-ChildItem -Filter "terraform.exe" | %{Rename-Item -Path $_.FullName -NewName "$($_.BaseName)_backup_$($_.CreationTime.ToString("yyyyMMdd"))$($_.Extension)"}

Expand-Archive -Path $TerraformLatestReleaseDownloadLink.innerText -DestinationPath $TerraformRootPath
