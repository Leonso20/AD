
get-adgroup -filter * | sort group | select Name

Get-ADGroup -filter {Name -like 'Human Resources'} -Properties * | select -Property name,cn,SamAccountName,groupcategory

Get-ADGroupMember -identity “Web Administrators” | select name,SamAccountName,objectClass | Export-csv -path C:\Groupmembers.csv -NoTypeInformation

Get-ADGroup -Filter {Name -like 'PublicSafetyHonorGuard'}  -Properties * | select -property SamAccountName,Name,Description,DistinguishedName,CanonicalName,GroupCategory,GroupScope,whenCreated
Get-ADGroup -Filter {Name -like 'Fire Department Honor*'}  -Properties * | select -property SamAccountName,Name,CanonicalName,GroupScope | ft

Get-ADGroupMember -identity “vpnusers” | select name,SamAccountName,objectClass | Export-csv -path C:\Groupmembers.csv -NoTypeInformation

Get-ADGroupMember -identity “Access to CIP_REPORTING”  | select -property  SamAccountName,Name | ft

Get-ADGroupMember -identity “Fire Department Honor Guard”  | select -property SamAccountName,Name,company,CanonicalName,GroupScope | ft



Get-ADGroupMember -identity “EA-SharePoint_Administrators” | Export-csv -path C:\PerfLogs

get-AdGroupMember -identity "EA-SharePoint_Administrators"  | select -property SamAccountName,Name,Description


Get-ADGroupMember 'Fire Department Honor Guard' |
  Get-ADUser -Properties EmailAddress |
  Where-Object { $_.Surname -eq 'foo' -and $_.GivenName -eq 'bar' } |
  Select-Object -Expand EmailAddress 


Get-ADGroupMember 'Shared - Retention Committee RW' |
  Where-Object { $_.objectClass -eq 'user' } |
  Get-ADUser -Properties EmailAddress |
  Where-Object { $_.Surname -eq 'foo' -and $_.GivenName -eq 'bar' } |
  Select-Object -Expand EmailAddress | Format-List 



Get-ADGroup -Filter {Name -like 'vpnusers'}  -Properties * | select -property SamAccountName,Name,Description,DistinguishedName,CanonicalName,GroupCategory,GroupScope,whenCreated
 Get-ADGroup Duo_Enrollment

Provisioning - Library RW

Get-ADGroupMember -identity “Duo_Enrollment”  | select SamAccountName,Name,Title,distinguishedName,Department | Export-csv -path C:\Users\aburgos02\Documents\Groupmembers.csv -NoTypeInformation

Get-ADGroupMember -identity 'Duo_Enrollment' -properties Department,Title,Company,Enabled,DisplayName,Mail,SAMAccountName,extensionAttribute10 | select Department,Company,Enabled,DisplayName,Mail,SAMAccountName,extensionAttribute10 | Export-csv -path C:\Groupmembers.csv -NoTypeInformation

Get-ADGroupMember -Identity "vpnusers" |  Sort-Object Name,Department,Title,Company | select Name,Department,Title,Company

Get-ADGroupMember -Identity "tnt"  | Select  Department,company,enabled,DisplayName,mail,SAMAccountName,extensionAttribute10, title | export-csv C:\Temp\extensionattribute3.csv

Get-ADGroupMember -Identity "tnt"  | select name


Get-ADGroupMember -Identity "Duo_Enrollment"  |  Sort-Object name, title | Select  SAMAccountName | export-csv \\semcty.net\is\SHARED\DUO\DUO-cutover\Duo_Enrollment.csv
Get-ADGroupMember -Identity "DUOVPNGroup"  |  Sort-Object name, title | Select  name,SAMAccountName, title | export-csv \\semcty.net\is\SHARED\DUO\DUO-cutover\DUOVPNGroup.csv
Get-ADGroupMember -Identity "DUOVPNGroup"  |  Sort-Object name, title | Select  name,SAMAccountName, title | export-csv C:\Temp\Duo.csv


get-content \\semcty.net\is\SHARED\DUO\DUO-cutover\DUOVPNGroup.csv


Get-ADGroupMember -Identity "Human_Resources"  |  Sort-Object  name, department | Select  name,department


Get-ADGroupMember -Identity "Human_Resources" | Sort-Object name | fl  name | export-csv -path c:\ob.csv -Verbose



Get-ADGroupMember -Identity "Facilities Program" | select name | fl name,enabled | export-csv -path c:\facilities.csv



#Find member of a security group 
$groupname = "Arosen"
$users = Get-ADGroupMember -Identity $groupname | ? {$_.objectclass -eq "user"}
foreach ($activeusers in $users) { Get-ADUser -Identity $activeusers | ? {$_.enabled -eq $true} | select Name, SamAccountName, UserPrincipalName, Enabled } 

Get-ADGroupMember -Identity "SC Department Directors & Chiefs" | Sort-Object name | select name | Export-Csv -path C:\Temp\SC.csv -NoTypeInformation