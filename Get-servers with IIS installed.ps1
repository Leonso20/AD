
$serverList = (Get-Content C:\servers.txt)
foreach ($server in $serverList) {

    $iis = Get-WmiObject Win32_Service -Filter "Name = 'IISADMIN'" -ComputerName $server

    if ($iis.State -eq 'Running') { Write-Host "IIS is running on $server" }
    Else { Write-Host "IIS is NOT running on $server" -ForegroundColor Red }

}