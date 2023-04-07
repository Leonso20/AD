import-module activedirectory
Search-ADAccount –LockedOut



#search ad accounts lockedout with the name
Search-ADAccount –LockedOut | select name


#How to find locked Active Directory accounts
Search-ADAccount -LockedOut -UsersOnly | Select-Object Name, SamAccountName



#How to unlock Active Directory accounts
Unlock-ADAccount -Identity RussellS



#Disabling users from a CSV file
$users=Import-CSV c:\temp\users.csv
ForEach ($user in $users)
{
     Disable-ADAccount -Identity $($user.name)
}


#
#Disabling computer accounts from a CSV file
$computers=Import-CSV c:\temp\computers.csv
ForEach ($computer in $computers)
{
     Disable-ADAccount -Identity "$($computer.name)$"
}


#Disabling inactive users
$timespan = New-Timespan -Days 90
Search-ADAccount -UsersOnly -AccountInactive -TimeSpan $timespan | Disable-ADAccount

Search-ADAccount -UsersOnly -AccountInactive -DateTime ‘6/3/2018’ | Disable-ADAccount