
$DaysInactive = 30
$time = (Get-Date).Adddays(-($DaysInactive))
  
# Get AD Users with lastLogonTimestamp less than time specified and is enabled
Get-ADUser -Filter {LastLogonTimeStamp -lt $time -and enabled -eq $true} -Properties LastLogonTimeStamp |
  
# Output Name and lastLogonTimestamp attributes into CSV
select-object Name,SamAccountName, @{Name="Stamp"; Expression={[DateTime]::FromFileTime($_.lastLogonTimestamp).ToString('yyyy-MM-dd')}} | export-csv Inactive_Users.csv -notypeinformation

#___________________________________________________________________________________________________________________________________________________________________________

#AD Account attributes - LastLogon, LastLogonTimeStamp and LastLogonDate

get-aduser -filter * -properties * | Where-Object {$_.lastlogondate -ge "7/01/2021"} | select name,lastlogondate | export-csv C:\Temp\users_not_logged_longer_than_90_day.csv -NoTypeInformation



get-aduser -filter * -properties * | Where-Object {$_.lastlogondate -ge (get-date).adddays(-160)}  | select name,lastlogondate


$d = [DateTime]::Today.AddDays(-180)

Get-ADUser -Filter '(PasswordLastSet -lt $d) -or (LastLogonTimestamp -lt $d)' -Properties PasswordLastSet,LastLogonTimestamp | ft Name,PasswordLastSet,@{N="LastLogonTimestamp";E={[datetime]::FromFileTime($_.LastLogonTimestamp)}}
