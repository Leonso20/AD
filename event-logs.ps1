systeminfo | find /i “Boot Time”



Get-EventLog -LogName System -EntryType Information -After 11/30/2022 -Source "Microsoft Antimalware" | Where-Object {$_.EventID -eq 5007} | fl




#who rebooted the server

Get-EventLog -LogName System -EntryType Information -After 1/01/2023  | Where-Object {$_.EventID -eq 1074} | ft
Get-EventLog -LogName System -EntryType Information -After 11/30/2022  | Where-Object {$_.EventID -eq 1074} | ft