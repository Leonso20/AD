Get-Acl \\semcty.net\Parks\Users\jortiz02-old | Format-List * | Get-Member


#However, this particular command cannot retrieve all the permissions of folders in the tree. To get the NTFS permissions report for all folders in a tree,
#the Get-Childtem command with a particular paramater -Recurse needs to be used. Then using the ForEach loop, we can pass the results to Get-Acl.
$FolderPath = Get-ChildItem -Directory -Path "\\semcty.net\Parks\Users\jortiz02-old" -Recurse -Force
$Output = @()
ForEach ($Folder in $FolderPath) {
    $Acl = Get-Acl -Path $Folder.FullName
    ForEach ($Access in $Acl.Access) {
$Properties = [ordered]@{'Folder Name'=$Folder.FullName;'Group/User'=$Access.IdentityReference;'Permissions'=$Access.FileSystemRights;'Inherited'=$Access.IsInherited}
$Output += New-Object -TypeName PSObject -Property $Properties            
}
}
$Output | Out-GridView


#Get-ACL and get permissions for specific user on a remote folder

$Folder = "\\semcty.net\Parks\Users\jortiz02-old"
$User = Read-Host "Input the sAMAccountName of user"
$permission = (Get-Acl $Folder).Access | ?{$_.IdentityReference -match $User} | Select IdentityReference,FileSystemRights
If ($permission){
$permission | % {Write-Host "User $($_.IdentityReference) has '$($_.FileSystemRights)' rights on folder $folder"}
}
Else {
Write-Host "$User Doesn't have any permission on $Folder"
}
