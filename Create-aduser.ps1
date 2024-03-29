$strLast = read-host "Enter the user's last name"
$strFirst = read-host "Enter the user's first name"
$strCompany = read-host "Enter the user's Department name (Public Works, Public Safety, etc)"
$strDept = read-host "Enter the user's Division name"
$strTitle = read-host "Enter the user's Title if known"
$strManager = read-host "Enter the manager's username (first initial and last name)"
$strPhone = read-host "Enter the user's phone number (if known)"
$strEmpID = read-host "Enter the user's Employee ID# (if known)"
$password = read-host "Enter password for user" -AsSecureString

$strName = $strLast + ', ' + $strFirst
$strInitial = $strFirst.substring(0,1)
$strLInitial = $strLast.substring(0,1)
$sAMAccountName = "$strInitial" + "$strLast"
$strUPN = $sAMAccountName + "@seminolecountyfl.gov"
$strDisplayName = $strName

switch ($strCompany)
    {
        "Administrative Services" {$OU = "OU=Users,OU=Admin Srvcs,OU=Semcty,DC=semcty,dc=net"; $MB="Semctyexch\AdminAndCommunityServices"}
        "Board of County Commissioners" {$OU = "OU=Users,OU=BCC,OU=Semcty,DC=semcty,dc=net"; $MB="Semctyexch\BCC"}
        "Community Services" {$OU = "OU=Users,OU=Community Services,OU=Semcty,DC=semcty,dc=net"; $MB="Semctyexch\AdminAndCommunityServices"}
        "County Attorney's Office" {$OU = "OU=Users,OU=County Attorney,OU=Semcty,DC=semcty,dc=net"; $MB="Semctyexch\BCC"}
        "County Manager's Office" {$OU = "OU=Users,OU=County Managers,OU=Semcty,DC=semcty,dc=net"; $MB="Semctyexch\BCC"}
        "Economic Development" {$OU = "OU=Users,OU=Economic Dev,OU=Semcty,DC=semcty,dc=net"; $MB="Semctyexch\HRandCommInfoAndEcoDev"}
        "Supervisor of Elections" {$OU = "OU=Users,OU=Elections,OU=Semcty,DC=semcty,dc=net"; $MB="Semctyexch\Elections"}
        "Environmental Services" {$OU = "OU=Users,OU=Environmental Srvcs,OU=Semcty,DC=semcty,dc=net"; $MB="Semctyexch\EnvironmentalServices"}
        "Fiscal Services" {$OU = "OU=Users,OU=Fiscal Srvcs,OU=Semcty,DC=semcty,dc=net"; $MB="Semctyexch\Fiscal"}
        "Human Resources" {$OU = "OU=Users,OU=HR,OU=Semcty,DC=semcty,dc=net"; $MB="Semctyexch\HRandCommInfoAndEcoDev"}
        "Information Technology Services" {$OU = "OU=Users,OU=IT,OU=Semcty,DC=semcty,dc=net"; $MB="Semctyexch\ITSandVendors"}
        "Leisure Services" {$OU = "OU=Users,OU=Leisure Services,OU=Semcty,DC=semcty,dc=net"; $MB="Semctyexch\ParksAndLibraries"}
        "Library Services" {$OU = "OU=Users,OU=Library Services,OU=Semcty,DC=semcty,dc=net"; $MB="Semctyexch\ParksAndLibraries"}
        "Planning and Development" {$OU = "OU=Users,OU=Planning and Dev,OU=Semcty,DC=semcty,dc=net"; $MB="Semctyexch\Planning"}
        "Public Safety" {$OU = "OU=Users,OU=Public Safety,OU=Semcty,DC=semcty,dc=net"}
        "Public Works" {$OU = "OU=Users,OU=Public Works,OU=Semcty,DC=semcty,dc=net"}
        Default {"Incorrect Company Name Entered"}
    }

If ($strCompany -eq "Public Safety") {
switch -regex ($strLInitial)
    {
        "[a-l]" {$MB = "Semctyexch\PublicSafetyA-L"}
        "[m-z]" {$MB = "Semctyexch\PublicSafetyM-Z"}
        default {"Initial was not a letter between A and Z"}
    }
}

If ($strCompany -eq "Public Works") {
switch -regex ($strLInitial)
    {
        "[a-l]" {$MB = "Semctyexch\PublicWorksA-L"}
        "[m-z]" {$MB = "Semctyexch\PublicWorksM-Z"}
        default {"Initial was not a letter between A and Z"}      
    }
}
write-host ""
write-host ====================================================================
write-host ""
write-host The following user will be created:
write-host ""
write-host SamAccountName=$sAMAccountName
write-host Email=$strUPN
write-host DisplayName=$strDisplayName
write-host OU=$OU
write-host Mailbox=$MB
write-host Manager=$strManager
write-host EmployeeID =$strEmpID

New-mailbox -OrganizationalUnit $OU -Name $strName -Password $password -UserPrincipalName $strUPN -alias $sAMAccountName -Database $MB -displayName $strDisplayName -SamAccountName $sAMAccountName -LastName $strLast -FirstName $strFirst -ResetPasswordOnNextLogon $true -confirm

Write-host ""
write-host ====================================================================
write-host ""
write-host Setting user account attributes
write-host ""

Set-QADUser $sAMAccountName -Manager $strManager -ObjectAttributes @{employeeid=$strEmpID;company=$strCompany;department=$strDept;title=$strTitle;telephonenumber=$strPhone}
