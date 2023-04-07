<#The get-aduser cmdlet is used to retrieve information about one or more Active Directory users. The -Identity parameter specifies the user identity to retrieve. In this case, the value of ScanServers is being used as the identity.

The -properties parameter is used to specify which properties of the user object to retrieve. In this case, the enabled and PasswordExpired properties are being retrieved.

The output of the get-aduser cmdlet is then piped to the select cmdlet, which is used to select specific properties to display. In this case, the samaccountname and enabled properties are being selected.

The resulting output will be a table showing the samaccountname and enabled properties of the user object with the identity of ScanServers #>



Get-aduser -Identity  ScanServers -properties enabled,PasswordExpired | select samaccountname,enabled

