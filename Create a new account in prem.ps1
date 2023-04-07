New-Mailbox -Name <Name> -UserPrincipalName <UPN> -Password (ConvertTo-SecureString -String '<Password>' -AsPlainText -Force) [-Alias <Alias>] [-FirstName <FirstName>] [-LastName <LastName>] [-DisplayName <DisplayName>] -[OrganizationalUnit <OU>]


Get-aduser -Identity apowell -Properties "*" | FL Surname,name,UserPrincipalName,firstname,lastname,DisplayName,OrganizationalUnit,cn,sAMAccountName,givenName,extensionAttribute10,distinguishedName

OU=Users,OU=Development Services,OU=SEMCTY,DC=SEMCTY,DC=NET

Get-ADUser -Identity ScanServers

Get-ADUser -Identity ScanRouter