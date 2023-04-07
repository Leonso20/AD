Get-ADUser -identity ea6 -properties PasswordLastSet, PasswordExpired, PasswordNeverExpires | Select Name, PasswordLastSet, PasswordExpired, PasswordNeverExpires 

Get-ADUser -identity ea7 -properties *  | Select-Object PasswordLastSet, PasswordExpired, PasswordNeverExpires | fl