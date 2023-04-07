Get-WmiObject -ClassName Win32_MappedLogicalDisk –ComputerName S102626.semcty.net | Select PSComputerName, Name,ProviderName

Test-WsMan S102626.semcty.net

$cred=Get-Credential
$sess = New-PSSession -Credential $cred -ComputerName S102626.semcty.net

$cred=Get-Credential
$sess = New-PSSession -Credential $cred -ComputerName S102626.semcty.net
Enter-PSSession $sess
Get-WmiObject -ClassName Win32_MappedLogicalDisk