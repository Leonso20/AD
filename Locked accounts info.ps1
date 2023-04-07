Get-ADDomainController -Filter *


Get-EventLog -LogName Security -ComputerName CSBDC03 -InstanceId 4740 -Newest 50 
Get-EventLog -LogName Security -ComputerName SOPSDC04 -InstanceId 4740 -Newest 50
Get-EventLog -LogName Security -ComputerName SOPSDC05 -InstanceId 4740 -Newest 50


Get-EventLog -LogName Security -ComputerName 172.20.200.71 -After 08:10 -Before (Get-Date) -InstanceId 4625 | Format-Table TimeCreated,Message -wrap


CSBDC03


Get-ADAccountLockReason -AccountName "CKelley"
