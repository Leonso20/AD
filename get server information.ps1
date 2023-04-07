# Get all the server in the ip range 
Get-ADComputer -Filter {OperatingSystem -Like "*server*"}

#You could also use an LDAP syntax filter:
Get-ADComputer -LDAPFilter "(operatingSystem=*server*)"

#you can use the same filter with other tools, like dsquery:
dsquery * -Filter "(operatingSystem=*server*)"

import-module Activedirectory

#can we get the list of all the servers present in the domain (included all the sub domain) through Active Directory management console or any command. If yes please share the steps or command
get-adcomputer -filter * | where {$_.OperatingSystem -like "$Server"}


#Get The firtered of the servers with same characteristics 
Get-ADComputer -Filter * -Property * | Format-Table Name,OperatingSystem,OperatingSystemServicePack,OperatingSystemVersion,LastLogonTimeStamp

Get-ADComputer -Filter * -Property * | Format-Table Name,OperatingSystem,OperatingSystemServicePack,OperatingSystemVersion,LastLogonTimeStamp -Wrap –Auto |sort-Property Operatingsystem - Asending|FT

Get-ADComputer -Filter * -Property * | Format-Table OperatingSystem