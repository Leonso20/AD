#PowerShell  retrieves the last password reset time for a user account in an Active Directory environment

# Import the Active Directory module
Import-Module ActiveDirectory

# Specify the username for which you want to retrieve the last password reset time
$username = "cocampo"

# Get the user object from Active Directory
$user = Get-ADUser -Identity $username -Properties PasswordLastSet

# Retrieve the PasswordLastSet property value
$passwordLastSet = $user.PasswordLastSet

# Convert the password last set time to a readable format
$passwordLastSetFormatted = $passwordLastSet.ToString("yyyy-MM-dd HH:mm:ss")

# Display the last password reset time
Write-Output "Last password reset time for user '$username': $passwordLastSetFormatted"
