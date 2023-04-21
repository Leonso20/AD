<#This is a PowerShell function named "Remove-IEIconFromTaskbar" that removes the Internet Explorer icon from the taskbar configuration on a remote computer.
The function takes one parameter, $ComputerName, which specifies the name of the remote computer.The function first defines an XML namespace to search for the target element,
then gets all user profile folders, including the Default User profile folder. For each user profile, it defines the file path of LayoutModification.xml and checks if the file exists.
If the file exists, it loads the XML content from the file and finds the target element to remove using an XPath query that searches for a specific DesktopApp element that represents 
the Internet Explorer icon on the taskbar. If the target element is found, it removes it from the XML content and saves the modified XML content back to the file. The function also writes
 output to the console to indicate whether the icon was found and removed or not, and for which user profile.To run the function, the user is prompted to enter the remote computer name, 
 and then the function is invoked using the specified computer name as the parameter value. The Invoke-Command cmdlet is used to run the script block on the remote computer.#>


 # Function to remove the Internet Explorer icon from the taskbar
function Remove-IEIconFromTaskbar {
    param (
        [string]$ComputerName
    )

    $ScriptBlock = {
        # Define the XML namespace to search for the target element
        $namespace = @{taskbar="http://schemas.microsoft.com/Start/2014/TaskbarLayout"}

        # Get all user profile folders
        $userProfileFolders = Get-ChildItem -Path "C:\Users" -Directory

        # Add the Default User profile folder
        $defaultUserProfile = New-Object -TypeName System.IO.DirectoryInfo -ArgumentList "C:\Users\Default"
        $userProfileFolders += $defaultUserProfile

        foreach ($userProfileFolder in $userProfileFolders) {
            # Define the file path of LayoutModification.xml for each user profile
            $filePath = Join-Path $userProfileFolder.FullName "AppData\Local\Microsoft\Windows\Shell\LayoutModification.xml"

            # Check if the LayoutModification.xml file exists for the user profile
            if (Test-Path $filePath) {
                # Load the XML content from the file
                [xml]$xmlContent = Get-Content -Path $filePath

                # Find the target element to remove
                $targetElement = (Select-Xml -Xml $xmlContent -Namespace $namespace -XPath '//taskbar:DesktopApp[@DesktopApplicationLinkPath="%APPDATA%\Microsoft\Windows\Start Menu\Programs\Accessories\Internet Explorer.lnk"]').Node

                # Remove the target element if found
                if ($targetElement -ne $null) {
                    $targetElement.ParentNode.RemoveChild($targetElement) | Out-Null

                    # Save the modified XML content back to the file
                    $xmlContent.Save($filePath)
                    Write-Host "[$($userProfileFolder.Name)] Removed the Internet Explorer icon from the taskbar configuration."
                } else {
                    Write-Host "[$($userProfileFolder.Name)] The Internet Explorer icon is not found in the taskbar configuration."
                }
            } else {
                Write-Host "[$($userProfileFolder.Name)] LayoutModification.xml file not found."
            }
        }
    }

    # Run the script block on the remote computer
    Invoke-Command -ComputerName $ComputerName -ScriptBlock $ScriptBlock
}

# Prompt the user for the remote computer name
$RemoteComputerName = Read-Host -Prompt "Enter the remote computer name"

# Run the function to remove the Internet Explorer icon from the taskbar on the remote computer
Remove-IEIconFromTaskbar -ComputerName $RemoteComputerName





