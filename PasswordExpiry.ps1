#Get the policy in place to change the password 

Get-ADDefaultDomainPasswordPolicy

#============================================================================================================================================================

#AD Users Passwords Expiration Dates with PowerShell
Get-ADUser -Identity ctaylor02 -Properties msDS-UserPasswordExpiryTimeComputed | select name, {[datetime]::FromFileTime($_.”msDS-UserPasswordExpiryTimeComputed”)}

#=================================================================================================================================================================

#get a list of Active Directory accounts and their password expiration times.
Get-ADUser -filter {Enabled -eq $True -and PasswordNeverExpires -eq $False} –Properties "DisplayName", "msDS-UserPasswordExpiryTimeComputed" |
Select-Object -Property "Displayname",@{Name="ExpiryDate";Expression={[datetime]::FromFileTime($_."msDS-UserPasswordExpiryTimeComputed")}} | Export-Csv -Path c:\password.csv -NoTypeInformation

Get-Content .\password.csv


# or

net user aburgos /domain

#=================================================================================================================================================================

#Find the Password Expiration Date for All Users with Powershell Script

$MaxPwdAge = (Get-ADDefaultDomainPasswordPolicy).MaxPasswordAge.Days
$expiredDate = (Get-Date).addDays(-$MaxPwdAge)
#Set the number of days until you would like to begin notifing the users. -- Do Not Modify --
#Filters for all users who's password is within $date of expiration.
$ExpiredUsers = Get-ADUser -Filter {(PasswordLastSet -gt $expiredDate) -and (PasswordNeverExpires -eq $false) -and (Enabled -eq $true)} -Properties PasswordNeverExpires, PasswordLastSet, Mail | select samaccountname, PasswordLastSet, @{name = "DaysUntilExpired"; Expression = {$_.PasswordLastSet - $ExpiredDate | select -ExpandProperty Days}} | Sort-Object PasswordLastSet
$ExpiredUsers |  Export-Csv -Path c:\password.csv -NoTypeInformation


Get-ADUser –Identity ctaylor02 –Properties msDS-UserPasswordExpiryTimeComputed|Select-Object -Property Name, @{Name="ExpiryDate";Expression={[datetime]::FromFileTime($_.msDS-UserPasswordExpiryTimeComputed)}}


#=============================================================================================================================================

#Interactive logon: Prompt user to change password before expiration

Get-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon' -Name PasswordExpiryWarning 

Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon' -Name PasswordExpiryWarning -Value 14

