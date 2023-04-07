
#Export information
Get-User -ResultSize Unlimited -Filter 'RemotePowerShellEnabled -eq $false' | Select-Object SamAccountName | Export-Csv C:\Temp\false.csv -NoTypeInformation
Get-User -ResultSize Unlimited -Filter 'RemotePowerShellEnabled -eq $true'  | Select-Object SamAccountName | Export-Csv C:\Temp\false.csv -NoTypeInformation

Get-User -ResultSize Unlimited -Filter 'RemotePowerShellEnabled -eq $true'  | Select-Object SamAccountName | Export-Csv C:\Temp\true.csv -NoTypeInformation

#Findout if user has Remote PowerShell Enabled
Get-user Wells, Elliott | set-user -RemotePowerShellEnabled $true


# disable Remote PowerShell
Set-User "sphilip" -RemotePowerShellEnabled $false

get-user -ResultSize unlimited | set-user -RemotePowerShellEnabled $false


#To display only those users who don't have access to remote PowerShell, run the following command
Get-User -ResultSize Unlimited -Filter 'RemotePowerShellEnabled -eq $false'


#Get users thta who have access 
Get-User -ResultSize Unlimited -Filter 'RemotePowerShellEnabled -eq $true'

Get-User -Identity jmiller03 | Format-List RemotePowerShellEnabled
Get-User -Identity emike | Format-List RemotePowerShellEnabled

Set-User "Therese Lindqvist" -RemotePowerShellEnabled $false


Get-User -ResultSize Unlimited -Filter 'RemotePowerShellEnabled -eq $false'  | Select-Object SamAccountName | Export-Csv C:\Temp\false.csv -NoTypeInformation
Get-User -ResultSize Unlimited -Filter 'RemotePowerShellEnabled -eq $true'  | Select-Object SamAccountName | Export-Csv C:\Temp\true.csv -NoTypeInformation



$NPS = Get-Content "C:\temp\new.txt" $NPS
$NPS | foreach {Set-User -Identity $_ -RemotePowerShellEnabled $false}
