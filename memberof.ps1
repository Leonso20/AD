(Get-ADuser -Identity gpieras -Properties memberof).memberof | Get-ADGroup | Select-Object name | Sort-Object name

(Get-ADuser -Identity monroer -Properties memberof).memberof

$Groups = (Get-ADuser -Identity rokum -Properties memberof).memberof | Get-ADGroup | Select-Object name | Sort-Object name | format 'C:\Users\AndresAdmin\attributes.txt'

$Groups = (Get-ADuser -Identity tstrawn -Properties memberof).memberof | Get-ADGroup | Select-Object name | Sort-Object name |  Format-Table –AutoSize > 'C:\Users\AndresAdmin\Documents\attributes.txt'


Get-Content -Path  C:\Users\AndresAdmin\Documents\NonAdmin_account_SG.txt

$Groups = (Get-ADuser -Identity kvakhordjian -Properties memberof).memberof | Format-Table –AutoSize > C:\Users\AndresAdmin\Documents\NonAdmin_account_SG.txt


$Groups = (Get-ADuser -Identity jdayton -Properties memberof).memberof | Format-Table –AutoSize > C:\Users\AndresAdmin\Documents\NonAdmin_account_SG.txt

$Groups = (Get-ADuser -Identity robertAdmin -Properties memberof).memberof | Format-Table –AutoSize > C:\Users\AndresAdmin\Documents\Admin_account_SG.txt

Compare-Object -ReferenceObject (Get-Content C:\Users\AndresAdmin\Documents\Admin_account_SG.txt) -DifferenceObject (Get-Content  C:\Users\AndresAdmin\Documents\NonAdmin_account_SG.txt) 



Get-ADGroup -Identity 'MDM – FD USAR'

$groupNames = 'MDM – FD USAR'
foreach ($group in $groupNames) {
    Get-ADGroupMember -Identity $group
}


Get-ADGroup -Identity 'MDM – FD USAR' -Properties * | Select-Object name,GroupCategory,GroupScope,whenCreated,ObjectClass | Fl 

 Get-ADGroupMember -Identity 'MDM – FD USAR'  | Select-Object name