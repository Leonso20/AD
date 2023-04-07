Get-ADComputer -Filter * -Property * |
Select-Object Name,OperatingSystem |
Export-CSV "C:\\ADcomputerslist.csv" -NoTypeInformation -Encoding UTF8