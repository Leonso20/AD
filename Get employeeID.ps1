Get-ADUser -Filter "*" -Property EmployeeID | Select Name,EmployeeId

Get-ADUser -Identity mbarnojohnson -Properties * | Select  CN,EmployeeId