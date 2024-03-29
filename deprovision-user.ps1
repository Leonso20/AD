## Prompt for input of userid
$userinput = Read-Host "Enter the username of the employee to deprovision"
$user = get-qaduser $userinput
if (!($user)) {
Write-Host "User not found in Active Directory. Please verify you are entering the correct UserID." -foregroundcolor red -backgroundcolor darkblue
exit
}

## Gather some info about the user (Last initial, Distinguished Name and OU)
$LInitial = ($user.lastname).substring(0,1)
$DN = $user.dn

## Hide user from GAL
Write-Host "--------------------------" -ForegroundColor Black -BackgroundColor Yellow
Write-Host "---Hiding User from GAL---" -foregroundcolor yellow -backgroundcolor darkblue
Write-Host "--------------------------" -ForegroundColor Black -BackgroundColor Yellow

set-mailbox $user.email -hiddenfromaddresslistsenabled $true -confirm

## Move Mailbox
switch -regex ($linitial)
    {
        "[a-l]" {$NewDB = "Semctyexch\DeletedUsersA-L"}
        "[m-z]" {$NewDB = "Semctyexch\DeletedUsersM-Z"}
        default {"Initial was not a letter between A and Z"}      
    }
Write-Host "----------------------------------------------" -ForegroundColor Black -BackgroundColor Yellow
Write-Host "---Moving Mailbox to Deleted Users Database---" -foregroundcolor yellow -backgroundcolor darkblue
Write-Host "----------------------------------------------" -ForegroundColor Black -BackgroundColor Yellow
move-mailbox $user.email -TargetDatabase $NewDB -confirm

## Disable AD account
Write-Host "--------------------------" -ForegroundColor Black -BackgroundColor Yellow
Write-Host "---Disabling AD Account---" -foregroundcolor yellow -backgroundcolor darkblue
Write-Host "--------------------------" -ForegroundColor Black -BackgroundColor Yellow
disable-qaduser $user -confirm

## Dump group memeberships and remove user from all groups
. P:\scripts\functions\Function-GroupMembership.ps1
DumpGroupMembership $userinput
$Groups = (Get-QADUser $user).memberof | Get-QADGroup
foreach ($group in $groups) {
Write-Host "-------------------------------------" -ForegroundColor Black -BackgroundColor Yellow
Write-Host "---Removing user from group $Group---" -foregroundcolor yellow -backgroundcolor darkblue
Write-Host "-------------------------------------" -ForegroundColor Black -BackgroundColor Yellow
Remove-QADGroupMember $group $user -confirm
}

## Add user to the Deleted Users Mailbox Archive group
Write-Host "------------------------------------------------------------" -ForegroundColor Black -BackgroundColor Yellow
Write-Host "---Adding user to the Deleted Users Mailbox Archive group---" -foregroundcolor yellow -backgroundcolor darkblue
Write-Host "------------------------------------------------------------" -ForegroundColor Black -BackgroundColor Yellow
add-qadgroupmember 'cn=Deleted Users Mailbox Archive,ou=Security Groups,ou=groups,ou=IT,ou=Semcty,dc=semcty,dc=net' $user -Confirm

## Move user account into appropriate Deleted Users OU
switch -wildcard ($DN)
    {
        "*OU=Admin Srvcs*" {$NewOU = "OU=Admin Srvcs,OU=Deleted Users,OU=Semcty,DC=semcty,dc=net"}
        "*OU=BCC*" {$NewOU = "OU=BCC,OU=Deleted Users,OU=Semcty,DC=semcty,dc=net"}
        "*OU=Community Information*" {$NewOU = "OU=Community Information,OU=Deleted Users,OU=Semcty,DC=semcty,dc=net"}
        "*OU=Community Services*" {$NewOU = "OU=Community Services,OU=Deleted Users,OU=Semcty,DC=semcty,dc=net"}
        "*OU=County Attorney*" {$NewOU = "OU=County Attorney,OU=Deleted Users,OU=Semcty,DC=semcty,dc=net"}
        "*OU=County Managers*" {$NewOU = "OU=County Managers,OU=Deleted Users,OU=Semcty,DC=semcty,dc=net"}
        "*OU=Economic Dev*" {$NewOU = "OU=Economic Dev,OU=Deleted Users,OU=Semcty,DC=semcty,dc=net"}
        "*OU=Elections*" {$NewOU = "OU=Elections,OU=Deleted Users,OU=Semcty,DC=semcty,dc=net"}
        "*OU=Environmental Srvcs*" {$NewOU = "OU=Environmental Srvcs,OU=Deleted Users,OU=Semcty,DC=semcty,dc=net"}
        "*OU=Fiscal Srvcs*" {$NewOU = "OU=Fiscal Srvcs,OU=Deleted Users,OU=Semcty,DC=semcty,dc=net"}
        "*OU=HR*" {$NewOU = "OU=HR,OU=Deleted Users,OU=Semcty,DC=semcty,dc=net"}
        "*OU=IT*" {$NewOU = "OU=IT,OU=Deleted Users,OU=Semcty,DC=semcty,dc=net"}
        "*OU=Leisure Services*" {$NewOU = "OU=Leisure Services,OU=Deleted Users,OU=Semcty,DC=semcty,dc=net"}
        "*OU=Library Services*" {$NewOU = "OU=Library Services,OU=Deleted Users,OU=Semcty,DC=semcty,dc=net"}
        "*OU=Planning and Dev*" {$NewOU = "OU=Planning and Dev,OU=Deleted Users,OU=Semcty,DC=semcty,dc=net"}
        "*OU=Public Safety*" {$NewOU = "OU=Public Safety,OU=Deleted Users,OU=Semcty,DC=semcty,dc=net"}
        "*OU=Public Works*" {$NewOU = "OU=Public Works,OU=Deleted Users,OU=Semcty,DC=semcty,dc=net"}
        Default {"User is in an unknown OU, skipping this step"}
    }
Write-Host "-----------------------------------------------" -ForegroundColor Black -BackgroundColor Yellow
Write-Host "---Moving user account into Deleted Users OU---" -foregroundcolor yellow -backgroundcolor darkblue
Write-Host "-----------------------------------------------" -ForegroundColor Black -BackgroundColor Yellow
move-adobject $user.dn -targetpath $NewOU -confirm
