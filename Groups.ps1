
get-adgroup -filter * | sort group | select Name

Get-ADGroup -filter {Name -like 'DUOADFS'} -Properties * | select -Property groupcategory,name,cn,SamAccountName

Get-ADGroupMember -identity “DUOVPNGroup” | select name,SamAccountName,objectClass | Export-csv -path C:\Groupmembers.csv -NoTypeInformation

Get-ADGroup -Filter {Name -like 'Fire Department Firefighter*'}  -Properties * | select -property SamAccountName,Name,Description,DistinguishedName,CanonicalName,GroupCategory,GroupScope,whenCreated
Get-ADGroup -Filter {Name -like 'MDm*'}  -Properties * | select -property SamAccountName,Name,CanonicalName,GroupScope | ft

Get-ADGroupMember -identity “MDM- PCD” | select name,SamAccountName,objectClass | Export-csv -path C:\Groupmembers.csv -NoTypeInformation

Get-ADGroupMember -identity “MDM- PCD”  | select -property  SamAccountName,Name | ft

Get-ADGroupMember -identity “vpnusers”  | select -property SamAccountName,Name,company,CanonicalName,GroupScope | ft

Get-ADGroupMember -identity “iboss_Allow_Netstorage” |select name |Export-Csv iboss_Allow_Netstorage.csv

Get-ADGroupMember -identity “iboss_Allow_Netstorage” | Export-csv -path C:\PerfLogs
        
get-AdGroupMember -identity "Duo_Enrollment" | select  name, distinguishedName
get-AdGroupMember -identity "Community Development"  | select name,company
get-AdGroupMember -identity "DUOADFS" | select name


Get-ADGroupMember 'Shared - Retention Committee RW' |
  Get-ADUser -Properties EmailAddress |
  Where-Object { $_.Surname -eq 'foo' -and $_.GivenName -eq 'bar' } |
  Select-Object -Expand EmailAddress 


Get-ADGroupMember 'Shared - Retention Committee RW' |
  Where-Object { $_.objectClass -eq 'user' } |
  Get-ADUser -Properties EmailAddress |
  Where-Object { $_.Surname -eq 'foo' -and $_.GivenName -eq 'bar' } |
  Select-Object -Expand EmailAddress | Format-List 



Get-ADGroup -Filter {Name -like 'DUOVPNGroup'}  -Properties * | select -property SamAccountName,Name,Description,DistinguishedName,CanonicalName,GroupCategory,GroupScope,whenCreated
 Get-ADGroup Duo_Enrollment

Provisioning - Library RW

Get-ADGroupMember -identity “Duo_Enrollment”  | select SamAccountName,Name,Title,distinguishedName,Department | Export-csv -path C:\Users\aburgos02\Documents\Groupmembers.csv -NoTypeInformation

Get-ADGroupMember -identity 'Duo_Enrollment' -properties Department,Title,Company,Enabled,DisplayName,Mail,SAMAccountName,extensionAttribute10 | select Department,Company,Enabled,DisplayName,Mail,SAMAccountName,extensionAttribute10 | Export-csv -path C:\Groupmembers.csv -NoTypeInformation

Get-ADGroupMember -Identity "vpnusers" |  Sort-Object Name,Department,Title,Company | select Name,Department,Title,Company

Get-ADGroupMember -Identity "vpnusers"  | Select  Department,company,enabled,DisplayName,mail,SAMAccountName,extensionAttribute10, title | export-csv C:\Temp\extensionattribute3.csv




Get-ADGroupMember -Identity "Duo_Enrollment"  |  Sort-Object name, title | Select  name,SAMAccountName, title | export-csv \\semcty.net\is\SHARED\DUO\DUO-cutover\Duo_Enrollment.csv
Get-ADGroupMember -Identity "DUOVPNGroup"  |  Sort-Object name, title | Select  name,SAMAccountName, title | export-csv \\semcty.net\is\SHARED\DUO\DUO-cutover\DUOVPNGroup.csv
Get-ADGroupMember -Identity "DUOVPNGroup"  |  Sort-Object name, title | Select  name,SAMAccountName, title | export-csv C:\Temp\Duo.csv


get-content \\semcty.net\is\SHARED\DUO\DUO-cutover\DUOVPNGroup.csv


Get-ADGroupMember -Identity "Duo_Enrollment"  |  Sort-Object * name, title,department | Select  name,SAMAccountName, title, department


Get-ADGroupMember -Identity "Duo_Enrollment" | Sort-Object Department,company,enabled,DisplayName,mail,SAMAccountName,extensionAttribute10, title | fl  Department,company,enabled,DisplayName,mail,SAMAccountName,extensionAttribute10, title


