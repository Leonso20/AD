

#This will display the current settings for the Wallpaper policy on the current user's account.
Get-ItemProperty -Path 'HKCU:\Control Panel\Desktop\' -Name WallPaper*
#This command generates a report that shows all the group policies that are applied to the current user's account. The report will be saved as an HTML file in the user's Documents folder.

Open the HTML report and search for the Wallpaper policy to find the group policy that is preventing the user from changing the wallpaper.
Get-GPResultantSetOfPolicy -User $env:USERNAME -ReportType HTML -Path $env:USERPROFILE\Documents\ResultantSetOfPolicy.html
