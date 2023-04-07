Get-ADComputer -Filter { OperatingSystem -Like '*Windows Server 2012*'} |
	ForEach-Object{
		Get-LoggedOnUser $_.Name
	} |
	Where-Object{
	   #state your filter requirements here
	}

