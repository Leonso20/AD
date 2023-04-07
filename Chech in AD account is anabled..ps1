

get-aduser -Identity  ScanServers -properties enabled,PasswordExpired | 
select samaccountname,enabled

