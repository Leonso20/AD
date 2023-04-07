$User = Read-Host -Prompt 'Enter UserName'
Get-Date | Out-File -Append \\is_csb\vol1\dp\nasa\userinfo\$User.txt
Get-ADUser $User -Properties * | Select-Object SamAccountName, EmailAddress, Company, Department, Title | Out-File -Append \\is_csb\vol1\dp\nasa\userinfo\$User.txt
Get-ADPrincipalGroupMembership $User | Select Name | Out-File -Append \\is_csb\vol1\dp\nasa\userinfo\$User.txt

Get-Content -Path \\is_csb\vol1\dp\nasa\userinfo\$User.txt

#========================================================================#============================================================================================================================

#Gets all memebrships from a single user


Get-AdPrincipalGroupMembership afunk | Select Name

#==========================================================================#===============================================================================================================================
#It removes all memebrships from a single user


$Username =  "tgross"


Get-ADPrincipalGroupMembership -Identity $Username | 
Where-Object {$_.Name -notlike "Domain Users"} | 
ForEach-Object {Remove-ADPrincipalGroupMembership -Identity $Username -MemberOf $_ -Confirm:$false} 

#===============================================================#======================================================================================================================================

Get-ADUser -Properties Description -Filter 'Description -like "Account will be deactivated*"' -SearchBase 'OU=SEMCTY,DC=SEMCTY,DC=NET' | 
select name,distinguishedname,description  | 
Export-Csv -path C:\description2.csv -NoTypeInformation

#===================================================================================================#=================================================================================================
#Validation 

$User = "tgross"

get-aduser -identity $User -Properties "*" | Select-Object employeeID,passwordlastset, cn,userPrincipalName,extensionAttribute10,extensionAttribute15,Description,company,department,whenChanged,
msRTCSIP-UserEnabled,msExchHideFromAddressLists,mail,telephoneNumber,manager,StreetAddress | FL

Get-ADPrincipalGroupMembership -Identity $User| select name


#=========================================================================================================================================================================================================

#To get an AD user with a specific title using PowerShell
Get-ADUser -Filter {Title -eq "Customer Service & Billing Manager"} -Properties *

Get-ADUser -Filter {Title -eq "Customer Service & Billing Manager"} -Properties SamAccountName, DisplayName, EmailAddress

