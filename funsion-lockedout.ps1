function Get-Lockout {
    Param(
        [parameter(Mandatory=$true)]
        [String]
        $Username 
        )
    $PDC = Get-ADDomainController -Discover -Service PrimaryDC
    Get-WinEvent -ComputerName $PDC -Logname Security -FilterXPath "*[System[EventID=4740] and EventData[Data[@Name='TargetUserName']='$Username']]" | Select-Object TimeCreated,@{Name='User Name';Expression={$_.Properties[0].Value}},@{Name='Source
Host';Expression={$_.Properties[1].Value}}|ft -Wrap -AutoSize
}

Get-Lockout kornberg

Search-ADAccount –LockedOut | select name


