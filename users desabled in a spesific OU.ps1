$sixMonthsAgo = (Get-Date).AddDays(-180)

$disabledUsers = Get-ADObject -Filter 'ObjectClass -eq "User" -and whenChanged -ge $sixMonthsAgo -and UserAccountControl -band 2'

$server = Get-ADDomainController

foreach ($disabledUser in $disabledUsers)
{
    Get-ADReplicationAttributeMetadata $disabledUser -Server $server -Properties UserAccountControl |
    Where-Object { $_.AttributeName -eq 'UserAccountControl' } | Select Object, LastOriginatingChangeTime |
    Where-Object { $_.LastOriginatingChangeTime -gt $sixMonthsAgo }
}


#This will give you a list of accounts that have not logged on since a specific date and are disabled:
Get-ADUser -Filter {Enabled -eq $False} -Properties name,sAMAccountName,lastLogonDate |
 Where-Object {$_.lastLogonDate -le [DateTime]::Now.AddDays(-180)} | Select name,sAMAccountName,lastLogonDate | Sort-Object name


 #This will do the same thing, but let you choose the OU to search in:
 Get-ADUser -Filter {Enabled -eq $False} -SearchBase "OU=Deleted Users,DC=SEMCTY,DC=NET" -Properties name,sAMAccountName,lastLogonDate | Where-Object {$_.lastLogonDate -le [DateTime]::Now.AddDays(-180)} | Select name,sAMAccountName,lastLogonDate | Sort-Object name




$date = (Get-Date).AddDays(-14)

$disabledUsers = Get-ADObject -Filter 'ObjectClass -eq "User" -and whenChanged -ge $sixMonthsAgo -and UserAccountControl -band 2'

$server = Get-ADDomainController

foreach ($disabledUser in $disabledUsers)
{
    Get-ADReplicationAttributeMetadata $disabledUser -Server $server -Properties UserAccountControl |
    Where-Object { $_.AttributeName -eq 'UserAccountControl' } | Select Object, LastOriginatingChangeTime |
    Where-Object { $_.LastOriginatingChangeTime -gt $date }
}

Search-ADAccount -SearchBase "OU=Deleted Users,DC=SEMCTY,DC=NET" -AccountDisabled -UsersOnly | Get-ADUser -Properties whenChanged | Where whenChanged -gt (Get-Date).AddDays(-180) | Select name, whenChanged,sAMAccountName |   Export-CSV "C:\Temp\DisabledUsers.CSV" -NoTypeInformation