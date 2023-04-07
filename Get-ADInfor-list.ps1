Get-ADComputer -Filter * -Properties *| Export-Csv C:\Temp\Adcomp.csv

Get-ADUser -Filter * -Properties * | export-csv c:\adusers.csv

Get-ADComputer -Filter * -Properties * | export-csv c:\adcomps.csv

Get-ADGroup -Filter * -Properties * | export-csv c:\adgroups.csv

Get-ADComputer -Filter * -Properties * | select name

$C=get-adcomputer -filter * -searchbase "OU=Computers,OU=Information Services,OU=SEMCTY,DC=SEMCTY,DC=NET"| ForEach-Object {$_.Name}
foreach($obj in $C) {
            Write-Host $obj
            Invoke-command -computername $obj -scriptblock {$CMD}
            }

            $C=get-adcomputer -filter * -searchbase "OU=Computers,OU=Information Services,OU=SEMCTY,DC=SEMCTY,DC=NET"| ForEach-Object {$_.Name}
foreach($obj in $C) {
            Write-Host $obj
            Invoke-command -computername $obj -scriptblock {$CMD}


            get-adcomputer -filter * -searchbase "OU=Computers,OU=Information Services,OU=SEMCTY,DC=SEMCTY,DC=NET" | select name | Export-Csv C:\temp\server.csv
            