$cutoff = 4800
$date = (Get-Date -Format yyyyMMdd)
$cutoffdate = (Get-Date).AddDays($cutoff * -1)  
Get-ADComputer `
    -Properties Name,IPv4Address,OperatingSystem,OperatingSystemVersion,LastLogonDate,whenCreated,DistinguishedName,CanonicalName,Enabled,Description `
    -Filter {LastLogonDate -gt $cutoffdate} |
    Select Name,IPv4Address,OperatingSystem,OperatingSystemVersion,LastLogonDate,whenCreated,DistinguishedName,CanonicalName,Enabled,Description |
    Export-Csv -NoTypeInformation c:\reports\$date"ADReport.csv"