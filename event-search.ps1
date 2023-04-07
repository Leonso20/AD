#nodes
Get-EventLog -LogName System -Newest 30 -EntryType Error -ComputerName PRINT01.semcty.net
Get-EventLog -LogName System -Newest 20 -EntryType Error -ComputerName sopsfs02.semcty.net

Get-EventLog -LogName System -Newest 20 -EntryType Error -ComputerName sopsfs01.semcty.net 

Get-EventLog -LogName System -Newest 20 -EntryType Error -ComputerName CSBFS01.semcty.net 
Get-EventLog -LogName System -Newest 20 -EntryType Error -ComputerName CSBFS02.semcty.net 


#Access client 
Get-EventLog -LogName System -Newest 30 -EntryType Error -ComputerName csbfc1.semcty.net 

Get-EventLog -LogName System -Newest 30 -EntryType Error -ComputerName sopsfc1.semcty.net
Get-EventLog -LogName System -Newest 30 -EntryType Error -ComputerName sopsfc2.semcty.net

Get-EventLog -LogName System -Newest 30 -EntryType Error -ComputerName spweb.semcty.net

Get-EventLog -LogName System -ComputerName spweb.semcty.net

Get-EventLog -LogName System  -Before 08/8/2022 -After 08/9/2022  -ComputerName spweb.semcty.net


