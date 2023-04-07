
#It removes all memebrships from a single user


Get-AdPrincipalGroupMembership aburgos | Select Name



$Username =  "dclarke"


Get-ADPrincipalGroupMembership -Identity $Username | 
Where-Object {$_.Name -notlike "Domain Users"} | 
ForEach-Object {Remove-ADPrincipalGroupMembership -Identity $Username -MemberOf $_ -Confirm:$false} 



