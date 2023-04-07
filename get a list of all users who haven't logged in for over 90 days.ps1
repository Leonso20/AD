﻿$logdate = Get-Date (get-date).AddDays(-90)
Search-ADAccount -AccountDisabled -UsersOnly -ResultPageSize 2000 -ResultSetSize $null | Where-Object {$_.lastLogon -le $logdate} | Select-Object name, SamAccountName | Export-CSV "C:\Temp\DisabledUsers.CSV" -NoTypeInformation