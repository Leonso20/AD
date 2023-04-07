<#This PowerShell script retrieves a list of computer names from Active Directory, checks if the file "LayoutModification.xml" exists in the default profile
or any user profile on each computer, and then creates an array of the computers that have the file.
#>

# Define the list of computer names
$computers = Get-ADComputer -Filter * | Select-Object -ExpandProperty Name

# Define the file paths to check for LayoutModification.xml
$defaultProfilePath = "C:\Users\Default\AppData\Local\Microsoft\Windows\Shell\LayoutModification.xml"
$userProfilePath = "C:\Users\*\AppData\Local\Microsoft\Windows\Shell\LayoutModification.xml"

# Create an empty array to store computers with the target file
$computersWithFile = @()

# Iterate through the list of computers
foreach ($computer in $computers) {
    # Test the connection to the computer
    if (Test-Connection -ComputerName $computer -Count 1 -Quiet) {
        # Check if the file exists in either of the specified paths
        $fileExistsDefault = Invoke-Command -ComputerName $computer -ScriptBlock {param($path) Test-Path $path} -ArgumentList $defaultProfilePath -ErrorAction SilentlyContinue
        $fileExistsUser = Invoke-Command -ComputerName $computer -ScriptBlock {param($path) Test-Path $path} -ArgumentList $userProfilePath -ErrorAction SilentlyContinue

        # If the file is found in either path, add the computer to the list
        if ($fileExistsDefault -or $fileExistsUser) {
            $computersWithFile += $computer
        }
    } else {
        Write-Host "Unable to connect to $computer"
    }
}

# Display the list of computers with the target file
$computersWithFile