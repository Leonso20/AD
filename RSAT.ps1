<#Use the following command to establish a remote PowerShell session to the target computer:
Replace <ComputerName> with the name of the remote computer and <UserName> with the username and password that has administrative rights on the remote computer.
Once you are connected to the remote computer, use the following command to install the RSAT tools:
#>

Enter-PSSession -ComputerName <ComputerName> -Credential <UserName>


#This command will install all available RSAT tools on the remote computer
Get-WindowsCapability -Online | Where-Object { $_.Name -like 'RSAT*' } | Add-WindowsCapability -Online


#Once the installation is complete, you can exit the remote PowerShell session by using the following command:

Exit-PSSession

#That's it! You have now installed RSAT remotely on the target computer using PowerShell.
