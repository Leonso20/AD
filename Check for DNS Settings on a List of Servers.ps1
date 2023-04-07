Get-CIMInstance Win32_NetworkAdapterConfiguration -computername (Import-Csv C:\temp\server.csv).server | 
     Where-Object { $_.IPEnabled -eq $TRUE} | 
         ForEach-Object{
             [PSCustomObject]@{
                 Servername                 = $_.DNShostname
                 IPAddress                  = [string]$_.ipaddress
                 Dnsserversearchorder       = [string]$_.dnsserversearchorder
                 FullDNSregistrationenabled = $_.fullDNSregistrationenabled
             }
         } | Export-Csv C:\temp\Nic.csv -NTI

        
        
         Get-Content C:\temp\Nic.csv