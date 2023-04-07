Get-Content "C:\Temp\servers_ .txt"  | ForEach-Object{
$os_name=$null
$os_version=$null
$errorMsg=''
Try
{
$os_name = (Get-WmiObject Win32_OperatingSystem -ComputerName $_ ).Caption
}
catch
{
$errorMsg=$_.Exception.Message
}
if(!$os_name){
$os_name = "The machine is unavailable $errorMsg"
$os_version = "The machine is unavailable"
}
else{
$os_version = (Get-WmiObject Win32_OperatingSystem -ComputerName $_ ).Version 
}
New-Object -TypeName PSObject -Property @{
ComputerName = $_
OSName = $os_name
OSVersion = $os_version
}} | Select ComputerName,OSName,OSVersion |
Export-Csv "C:\Temp\OS_Details2008.csv" -NoTypeInformation -Encoding UTF8

ping 10.10.63.90

Get-WmiObject Win32_OperatingSystem -ComputerName "10.10.63.90" |
Select PSComputerName, Caption, OSArchitecture, Version, BuildNumber | FL