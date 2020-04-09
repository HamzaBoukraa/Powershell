Clear-Host;
$FirstUser = $true;
$IntersectGroups = @();
$UnionGroups = @();
$Users = Import-Csv -Delimiter ";" -Path "TeamMembers.csv" -Encoding UTF8
$Users.Where{$_.Active -eq "Yes"}
foreach($User in $Users.Where{$_.Active -eq "Yes"}){
    $TempLiteralGroups = ((New-Object System.DirectoryServices.DirectorySearcher("(&(objectCategory=User)(samAccountName=$($User.Id)))")).FindOne().GetDirectoryEntry().memberOf);
    $TempGroups = @();
    $TempIntersectGroups = @();
    foreach($TempLiteralGroup in $TempLiteralGroups){
        $TempGroups += (($TempLiteralGroup.Split(","))[0].Split("="))[1];
    }
    foreach($TempGroup in $TempGroups){
        if($FirstUser){
            "Adding $TempGroup To intesect group";
            $IntersectGroups += $TempGroup;
        }
        else{
            if($IntersectGroups.Where{$_ -eq $TempGroup}.Count -ne 0){
                "Keeping $TempGroup In intesect group";
                $TempIntersectGroups += $TempGroup;
            }
            else{
                "Removing $TempGroup From intesect group";
            }
        }
        if($UnionGroups.Where{$_ -eq $TempGroup}.Count -eq 0){
            "Adding $TempGroup To union group";
            $UnionGroups += $TempGroup
        }
    }
    if(-not $FirstUser){
        $IntersectGroups = $TempIntersectGroups;
    }
    $FirstUser = $false;
    Wrtie-Host "************";
    Wrtie-Host "User : $User";
    Wrtie-Host "************";
    Wrtie-Host "Unions ($($UnionGroups.Count)) :`r`n$UnionGroups";
    Wrtie-Host "************";
    Wrtie-Host "Intersect ($($IntersectGroups.Count)) :`r`n$IntersectGroups";
    Wrtie-Host "************";
}
