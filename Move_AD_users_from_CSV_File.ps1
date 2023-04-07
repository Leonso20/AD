#################################################################
# This script will help yo move bulk ad accounts into target OU
#################################################################
# Import AD Module
import-module ActiveDirectory

# Import CSV 
$MoveList = Import-Csv -Path "C:\Temp\Acc_MoveList.csv"
# Specify target OU.This is where users will be moved.
$TargetOU =  "CN=Duo_Enrollment,OU=Groups,OU=Vendors,DC=SEMCTY,DC=NET"
# Import the data from CSV file and assign it to variable 
$Imported_csv = Import-Csv -Path "C:\Temp\Acc_MoveList.csv" 

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