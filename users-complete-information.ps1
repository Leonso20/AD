get-content C:\Users.txt | get-aduser -Properties "*" | Select-Object employeeID, cn,userPrincipalName,MemberOf,extensionAttribute10,extensionAttribute15,PasswordLastSet,Description,company,department,whenChanged,msRTCSIP-UserEnabled,msExchHideFromAddressLists,mail,manager | FL

get-content C:\Users.txt | get-aduser -Properties "*" | Select-Object employeeID, cn,userPrincipalName,mail,telephoneNumber,Description,manager | FL

Get-ADUser -Properties Description -Filter 'Description -like "Account will be deactivated after the 6/10/2022 TC has been processed*"' -SearchBase 'OU=SEMCTY,DC=SEMCTY,DC=NET' | select name,distinguishedname,description


$User = "cvo-akiff"

get-aduser -identity $User -Properties "*" | Select-Object passwordlastset, cn,userPrincipalName,Description,whenChanged,mail | FL

(Get-ADuser -Identity $User -Properties memberof).memberof

get-aduser -identity $User -Properties "*" | Select-Object employeeID,passwordlastset, cn,userPrincipalName,extensionAttribute10,extensionAttribute15,Description,company,department,whenChanged,msExchHideFromAddressLists,mail,manager,memberof | FL

get-aduser -filter *  -Properties "*" | Select-Object cn,userPrincipalName,mail | Ft

get-aduser -filter * -Properties "*" | Select-Object name,mail,telephoneNumber,DisplayName  | FT

Get-ADUser -Filter {Enabled -eq $True} -Properties "*" | Select-Object name,mail,telephoneNumber,DisplayName  | Export-CSV C:\Temp\EDactive_accounts.csv