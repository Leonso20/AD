#It provides the distinguishedName
(Get-ADUser dlong –Properties MemberOf | Select-Object MemberOf).MemberOf


#It provides user information
net user /domain dlong




# it expot a csv file in C: location
Get-ADPrincipalGroupMembership dlong | Select name  | Export-Csv -NoTypeInformation .\ad_group.csv



#You can use the filter by group name:
Get-ADPrincipalGroupMembership zwelch| where {$_ -like "*Access*"} | Sort-Object | select -ExpandProperty name



#Using the following command, you can list the security groups that your account is a member of:
whoami /groups
