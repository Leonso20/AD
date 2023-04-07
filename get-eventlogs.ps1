$A = Get-EventLog -LogName System -Newest 1

$A | Select-Object -Property *


Get-EventLog -LogName “Windows Powershell” -Source PowerShell | Where-Object {$_.EventID -eq 600} | Select-Object -Property Source, EventID, InstanceId, Message


Get-EventLog -LogName System -ComputerName spsql -After "2022/11/11" | Where-Object {$_.EventID -in (1074,1076,6006,6008)}

Get-EventLog -LogName System -ComputerName spsql -After "2022/11/11" | Where-Object {$_.EventID -in (1074,1076,6006,6008)} | Format-Table TimeGenerated, EventID, Message -Wrap