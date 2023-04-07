Get-CimInstance -ComputerName (Get-Content -Path 'C:\Temp\servers.txt') -Class CIM_OperatingSystem -ErrorAction Stop | Select-Object CSName, LastBootUpTime | Out-GridView

Get-CimInstance -ComputerName (Get-Content -Path 'C:\Temp\servers.txt') -Class CIM_OperatingSystem -ErrorAction Stop | Select-Object CSName, LastBootUpTime | Out-GridView