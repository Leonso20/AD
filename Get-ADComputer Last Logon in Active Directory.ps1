#Get-ADComputer Last Logon in Active Directory
Get-ADComputer -Filter * -Properties * | Sort LastLogon | Select Name, LastLogonDate,@{Name='LastLogon';Expression={[DateTime]::FromFileTime($_.LastLogon)}} | Export-Csv C:\adcomputers-last-logon.csv -NoTypeInformation


#PowerShell Last Logon Computer in OU
Get-ADComputer -Filter * -SearchBase "OU=Servers,DC=SHELLPRO,DC=LOCAL" -Properties * | Sort LastLogon | Select Name, LastLogonDate,@{Name='LastLogon';Expression={[DateTime]::FromFileTime($_.LastLogon)}} | Export-Csv C:\adcomputers-last-logon-ou.csv -NoTypeInformation


Get-ADComputer -Identity s102352 -Properties * | Sort LastLogon | Select Name, LastLogonDate,@{Name='LastLogon';Expression={[DateTime]::FromFileTime($_.LastLogon)}}