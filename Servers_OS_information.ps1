#Retrieve all Windows Server Computer
Get-ADComputer -Filter 'operatingsystem -like "*server*" -and enabled -eq "true"' `
-Properties Name,Operatingsystem,OperatingSystemVersion,IPv4Address |
Sort-Object -Property Operatingsystem |
Select-Object -Property Name,Operatingsystem,OperatingSystemVersion,IPv4Address

#Retrieve all Windows Client Computer
Get-ADComputer -Filter 'operatingsystem -notlike "*server*" -and enabled -eq "true"' `
-Properties Name,Operatingsystem,OperatingSystemVersion,IPv4Address |
Sort-Object -Property Operatingsystem |
Select-Object -Property Name,Operatingsystem,OperatingSystemVersion,IPv4Address

#Retrieve all Domain-Controllers (no Member-Server)
Get-ADComputer -Filter 'primarygroupid -eq "516"' `
-Properties Name,Operatingsystem,OperatingSystemVersion,IPv4Address |
Sort-Object -Property Operatingsystem |
Select-Object -Property Name,Operatingsystem,OperatingSystemVersion,IPv4Address

##Retrieve all Member-Server To retrieve all servers that are not Domain-Controllers, run the following code.
Get-ADComputer -Filter 'operatingsystem -like "*server*" -and enabled -eq "true" -and primarygroupid -ne "516"' `
-Properties Name,Operatingsystem,OperatingSystemVersion,IPv4Address |
Sort-Object -Property Operatingsystem |
Select-Object -Property Name,Operatingsystem,OperatingSystemVersion,IPv4Address

#Retrieve all Computer sorted by Operatingsystem Last but not least, we retrieve all domain-computers by running the following code.
Get-ADComputer -Filter 'enabled -eq "true"' `
-Properties Name,Operatingsystem,OperatingSystemVersion,IPv4Address |
Sort-Object -Property Operatingsystem |
Select-Object -Property Name,Operatingsystem,OperatingSystemVersion,IPv4Address | Out-GridView


Get-ADComputer -Filter {OperatingSystem -Like "Windows *Server 2012*"} -Property * | Format-Table Name,OperatingSystem,OperatingSystemServicePack -Wrap -Auto

Get-ADComputer -Filter {OperatingSystem -Like "Windows *Server 2012*"} -Property * | Format-Table Name, description -Wrap -Auto |Export-Csv C:\Temp\server_2012.csv

Get-ADComputer -Filter {OperatingSystem -Like "Windows *Server 2003*"} -Property * | Format-Table Name, description  | Export-Csv -path C:\Temp\server_2012.csv -NoTypeInformation

Get-ADComputer -Filter {OperatingSystem -Like "Windows *Server 2008*"} -Property * | select name, description | Export-Csv -path C:\Temp\server_2012.csv -NoTypeInformation

#=================================================================================================================================================================================

$computers = Get-Content -Path 'C:\Temp\servers_2008 .txt'
Foreach($c in $computers) {
IF (Test-Connection -BufferSize 32 -Count 1 -ComputerName $c -Quiet) {
        Write-Host "The remote computer " $c " is Online"
} Else {
        Write-Host "The remote computer " $c " is Offline"
}}



$computers = Get-Content -path 'C:\Temp\servers-2003.txt'
Foreach($c in $computers) {
IF (Test-Connection -BufferSize 32 -Count 1 -ComputerName $c -Quiet) {
        Write-Host "The remote computer " $c " is Online"
}}

Get-Content -Path 'C:\Temp\servers-2003.txt'

$computers = Get-Content -path 'C:\Temp\servers_2008 .txt'
Foreach($c in $computers) {
IF (Test-Connection -BufferSize 32 -Count 1 -ComputerName $c -Quiet) {
        Write-Host "The remote computer " $c " is Online"
}}





Get-WmiObject Win32_OperatingSystem -ComputerName "SOPSSQL06" | Select PSComputerName, Caption, OSArchitecture, Version, BuildNumber | FL




ping CSBSQL02

nslookup 172.20.107.104

 Get-ADComputer -Filter "OperatingSystem -Like '*Windows Server 2003*' -and Enabled -eq 'True'" | select name


 $computers = Get-Content -Path 'C:\Temp\servers-2003.txt'
Foreach($c in $computers) {
IF (Test-Connection -BufferSize 32 -Count 1 -ComputerName $c -Quiet) {
        Write-Host "The remote computer " $c " is Online"
} Else {
        Write-Host "The remote computer " $c " is Offline"
}}


Get-Content -Path 'C:\Temp\servers_2008 .txt'| ForEach-Object{
$pingstatus = ""
IF (Test-Connection -BufferSize 32 -Count 1 -ComputerName $_ -Quiet) {
        $pingstatus = "Online"
} Else {
        $pingstatus = "Offline"
}

New-Object -TypeName PSObject -Property @{
      Computer = $_
      Status = $pingstatus }
} | Export-Csv C:\Users\ea6\Temp\PingStatus.csv -NoTypeInformation -Encoding UTF8





#How to Ping a list of Computer in PowerShell
 $computers = Get-Content -Path "C:\Temp\servers-2003.txt"
 foreach ($computer in $computers)
     {
     $ip = $computer.Split(" - ")[0]
     if (Test-Connection  $ip -Count 1 -ErrorAction SilentlyContinue){
         Write-Host "$ip is up"
         }
     else{
         Write-Host "$ip is down"
         }
     }