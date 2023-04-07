

Connect-AzureAD

Connect-MSOLService


Get-MsolAccountSku

#Next, run this command to list the services that are available in each licensing plan, and the order in which they are listed (the index number).
(Get-MsolAccountSku | where {$_.AccountSkuId -eq "seminolecountyfl:ENTERPRISEPACK_GOV"}).ServiceStatus


#This example shows the services that user BelindaN@litwareinc.com has access to from the first license that's assigned to her account (the index number is 0).
(Get-MsolUser -UserPrincipalName aburgos02@seminolecountyfl.gov).Licenses[0].ServiceStatus

#This example shows the services to which the user BelindaN@litwareinc.com has access. This shows the services that are associated with all licenses that are assigned to her account.
(Get-MsolUser -UserPrincipalName aburgos@seminolecountyfl.gov).Licenses.ServiceStatus


(Get-MsolUser -UserPrincipalName aburgos@seminolecountyfl.gov).Licenses[<LicenseIndexNumber>].ServiceStatus

#To view all the services for a user who has been assigned multiple licenses, use the following syntax:
$userUPN="aburgos02@seminolecountyfl.gov"
$AllLicenses=(Get-MsolUser -UserPrincipalName $userUPN).Licenses
$licArray = @()
for($i = 0; $i -lt $AllLicenses.Count; $i++)
{
$licArray += "License: " + $AllLicenses[$i].AccountSkuId
$licArray +=  $AllLicenses[$i].ServiceStatus
$licArray +=  ""
}
$licArray


########################################################################################################################
Connect-MsolService and enter your credentials.

Get-MsolUser -All | Where-Object { $_.Licenses.ServiceStatus.ServicePlan.ServiceName -match "TEAMS"} | Select-Object UserPrincipalName, DisplayName | Export-Csv D:\new\AAA.csv