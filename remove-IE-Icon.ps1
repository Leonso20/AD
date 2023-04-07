
#This is a PowerShell script that removes the Internet Explorer icon from the taskbar for all user accounts on a Windows computer.

$UserFolders = Get-ChildItem C:\Users -Directory
foreach ($UserFolder in $UserFolders) {
    $QuickLaunchPath = "$($UserFolder.FullName)\AppData\Roaming\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar"
    if (Test-Path $QuickLaunchPath) {
        $IEIcon = Get-ChildItem -Path $QuickLaunchPath -Filter "Internet Explorer.lnk" -File -ErrorAction SilentlyContinue
        if ($IEIcon) {
            Remove-Item $IEIcon.FullName -Force
        }
    }
}



Remove-Item -Path "$env:APPDATA\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\Internet Explorer.lnk"


$UserFolders = Get-ChildItem C:\Users -Directory
foreach ($UserFolder in $UserFolders) {
    $QuickLaunchPath = "$($UserFolder.FullName)\AppData\Roaming\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar"
    if (Test-Path $QuickLaunchPath) {
        $IEIcon = Get-ChildItem -Path $QuickLaunchPath -Filter "Internet Explorer.lnk" -File -ErrorAction SilentlyContinue
        if ($IEIcon) {
            Remove-Item $IEIcon.FullName -Force | Remove-Item -Path "$env:APPDATA\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\Internet Explorer.lnk"
        }
    }
}
