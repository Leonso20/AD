Get-ADUser -Properties Description -Filter 'Description -like "The account will be*"' -SearchBase 'OU=SEMCTY,DC=SEMCTY,DC=NET' | 
select name,distinguishedname,description  | Export-Csv -path C:\description2.csv -NoTypeInformation




$User = Read-Host -Prompt 'Enter UserName'
Get-Date | Out-File -Append \\is_csb\vol1\dp\nasa\userinfo\$User.txt
Get-ADUser $User -Properties * | Select-Object SamAccountName, EmailAddress, Company, Department, Title | Out-File -Append \\is_csb\vol1\dp\nasa\userinfo\$User.txt
Get-ADPrincipalGroupMembership $User | Select Name | Out-File -Append \\is_csb\vol1\dp\nasa\userinfo\$User.txt

get-aduser -identity rmanka -Properties "*" | Select-Object employeeID,passwordlastset, cn,userPrincipalName,extensionAttribute10,extensionAttribute15,Description,company,department,whenChanged,msExchHideFromAddressLists,mail,manager | FL


Get-ADUser -Properties Description -Filter 'Description -like "The account will be deactivated on 9/30/2022 after the TC has been processed*"' -SearchBase 'OU=SEMCTY,DC=SEMCTY,DC=NET' | 
select name,description 



get-aduser -identity rmanka -Properties "*" | Select-Object cn,passwordlastset,userPrincipalName,Description,whenChanged | FL
