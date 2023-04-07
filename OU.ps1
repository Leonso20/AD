Get-ADOrganizationalUnit -Filter 'Name -like "information*"' | Format-Table cn,Name, DistinguishedName -A

Get-ADOrganizationalUnit -Filter 'Name -like "groups*"' | Format-Table Name, DistinguishedName -A

Get-ADOrganizationalUnit -Filter 'Name -like "groups*"' | Format-Table cn,Name,ObjectClass,groups -A
Get-ADOrganizationalUnit -Filter 'Name -like "semcty"' | FT Name, DistinguishedName -A
Get-ADOrganizationalUnit -Identity 'OU=SEMCTY,DC=SEMCTY,DC=NET'  | ft  -A
Get-ADOrganizationalUnit -WarningAction 'semcty.net'  | ft  -A


Get-ADOrganizationalUnit -Filter 'Name -like "vendors*"' | Format-Table cn,Name, DistinguishedName -A
Get-ADGroup -Filter 'Duo_Enrollment' | Format-Table cn,Name, DistinguishedName -A

Get-ADGroupMember -Identity DUOVPNGroup | Format-Table cn,Name, DistinguishedName -A

Get-ADOrganizationalUnit  -Filter 'Name -like "h*"' | Format-Table -A cn,Name, DistinguishedName -A

Get-ADGroup -Identity Duo_Enrollment

Get-ADGroup -Identity DUOVPNGroup



get-aduser -filter * -searchbase "OU*" -Properties name | select name | ft

get-aduser -filter * -searchbase "OU=Groups,OU=Vendors,DC=SEMCTY,DC=NET" | -select-object name


Get-ADOrganizationalUnit -filter * -searchbase "OU=Fire Department,OU=SEMCTY,DC=SEMCTY,DC=NET" | -select-object name

Get-ADOrganizationalUnit -filter * 



$OUpath = 'OU=County Managers,OU=SEMCTY,DC=SEMCTY,DC=NET'
$ExportPath = 'c:\temp\users_in_ou1.csv'
Get-ADUser -Filter 'Enabled -eq $True' -SearchBase $OUpath | select name, UserPrincipalName | Export-Csv C:\temp\ou.csv -notypeinformation

#Get all of the OUs in a domain
Get-ADOrganizationalUnit -Filter 'Name -like "*"' | Format-Table Name, DistinguishedName -A


#----------------------------------------------------------------------------------------------------------------------------------------

$OUpath = 'CN=Duo_Enrollment,OU=Groups,OU=Vendors,DC=SEMCTY,DC=NET'
$ExportPath = 'C:\temp\data\Duo_Enrollment.csv'
Get-ADUser -Filter * -SearchBase $OUpath | Select-object DistinguishedName, Name,UserPrincipalName | Export-Csv -NoType $ExportPath -WhatIf


$ExportPath = 'C:\temp\data\Duo_Enrollment.csv'
Get-ADGroupMember -Identity Duo_Enrollment | Select-object SamAccountName,name,DistinguishedName |  Export-Csv -NoType $ExportPath

$ExportPath = 'C:\temp\data\DUOVPNGroup.csv'
Get-ADGroupMember -Identity DUOVPNGroup | Select-object SamAccountName,Name,distinguishedName | Export-Csv -NoType $ExportPath


#################################################################
# This script will help yo move bulk ad accounts into target OU
#################################################################
# Import AD Module
import-module ActiveDirectory

# Import CSV 
$MoveList = Import-Csv -Path "C:\Temp\data\Duo_Enrollment.csv"
# Specify target OU.This is where users will be moved.
$TargetOU =  "CN=DUOVPNGroup,OU=Groups,OU=Vendors,DC=SEMCTY,DC=NET"
# Import the data from CSV file and assign it to variable 
$Imported_csv = Import-Csv -Path "C:\Temp\data\Acc_MoveList.csv" 

$Imported_csv | ForEach-Object {
     # Retrieve DN of User.
     $UserDN  = (Get-ADUser -Identity $_.Name).distinguishedName
     Write-Host " Moving Accounts ..... "
     # Move user to target OU.
     Move-ADObject  -Identity $UserDN  -TargetPath $TargetOU
     
 } 
 Write-Host " Completed move " 
 $total = ($MoveList).count
 $total
 Write-Host "Accounts have been moved succesfully..." 

 get-aduser mrosamunger

 



 get-aduser -filter * -searchscope subtree -searchbase "CN=Users,DC=SEMCTY,DC=NET" -properties

 ####################################################################################################################################################################################

  Get-ADOrganizationalUnit -Filter 'Name -like "Facilities"'

 $OUpath = 'OU=County Managers,OU=SEMCTY,DC=SEMCTY,DC=NET'
$ExportPath = 'c:\temp\users_in_ou1.csv'
Get-ADUser -Filter 'Enabled -eq $True' -SearchBase $OUpath | select name, UserPrincipalName | Export-Csv C:\temp\ou.csv -notypeinformation



$OU = 'OU=County Managers,OU=SEMCTY,DC=SEMCTY,DC=NET'
# Use Get-AdUser to search within organizational unit to get users name
Get-ADUser -Filter 'Enabled -eq $True' -SearchBase $OU | Select-object Name,description | Export-Csv C:\temp\county_Managers.csv -notypeinformation