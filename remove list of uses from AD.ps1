# Start transcript
Start-Transcript -Path C:\Temp\Remove-ADUsers.log -Append

# Import AD Module
Import-Module ActiveDirectory


#get the users in Duo_enrollment group that need to be removed. 
Get-ADGroupMember -Identity "DUOVPNGroup"  |  Sort-Object SAMAccountName | Select  SAMAccountName | export-csv C:\Temp\UserList.csv

Get-ADGroupMember -Identity "CN=DUOVPNGroup,OU=Groups,OU=Vendors,DC=SEMCTY,DC=NET" | select SAMAccountName 



# Import the data from CSV file and assign it to variable
$Users = Import-Csv C:\Temp\UserList.csv  


# Specify target group where the users will be removed from
# You can add the distinguishedName of the group. For example: CN=Pilot,OU=Groups,OU=Company,DC=exoip,DC=local
$Group = "CN=DUOVPNGroup,OU=Groups,OU=Vendors,DC=SEMCTY,DC=NET" 

foreach ($User in $Users) {
    # Retrieve UPN
    $UPN = $User.name

    # Retrieve UPN related SamAccountName
    $ADUser = Get-ADUser -Filter "name -eq '$UPN'" | Select-Object SamAccountName
    
    # User from CSV not in AD
    if ($ADUser -eq $null) {
        Write-Host "$UPN does not exist in AD" -ForegroundColor Red
    }
    else {
        # Retrieve AD user group membership
        $ExistingGroups = Get-ADPrincipalGroupMembership $ADUser.SamAccountName | Select-Object Name

        # User member of group
        if ($ExistingGroups.Name -eq $Group) {

            # Remove user from group
            Remove-ADGroupMember -Identity $Group -Members $ADUser.SamAccountName -Confirm:$false 
            Write-Host "Removed $UPN from $Group" -ForeGroundColor Green
       
            Write-Host "$UPN does not exist in $Group" -ForeGroundColor Yellow
        }
    }
}
Stop-Transcript



