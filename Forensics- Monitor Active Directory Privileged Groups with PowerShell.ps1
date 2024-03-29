﻿Function Get-PrivilegedGroupChanges {            
Param(            
    $Server = (Get-ADDomainController -Discover | Select-Object -ExpandProperty HostName),            
    $Hour = 24            
)            
            
    $ProtectedGroups = Get-ADGroup -Filter 'AdminCount -eq 1' -Server $Server            
    $Members = @()            
            
    ForEach ($Group in $ProtectedGroups) {            
        $Members += Get-ADReplicationAttributeMetadata -Server $Server `
            -Object $Group.DistinguishedName -ShowAllLinkedValues |            
         Where-Object {$_.IsLinkValue} |            
         Select-Object @{name='GroupDN';expression={$Group.DistinguishedName}}, `
            @{name='GroupName';expression={$Group.Name}}, *            
    }            
            
    $Members |            
        Where-Object {$_.LastOriginatingChangeTime -gt (Get-Date).AddHours(-1 * $Hour)}            
            
}            
            
            
# Last 24 hours            
Get-PrivilegedGroupChanges            
            
# Last week            
Get-PrivilegedGroupChanges -Hour (7*24)| Out-Gridview           
            
# Specific DC, 30 days (24 hours x 30 days)            
Get-PrivilegedGroupChanges -Server CSBDC01.semcty.net -Hour (24*30)            
            
# Last year of group changes            
Get-PrivilegedGroupChanges -Hour (365*24) |            
    Export-Csv -Path .\PrivGroupMembershipChanges.csv -NoTypeInformation       