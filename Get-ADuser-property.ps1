get-aduser -Identity mkinley  -Properties * | select UserPrincipalName,department,company,cn,manager | Export-Csv C:\Temp\userinfo.csv -NoTypeInformation -Encoding UTF8

get-aduser -Identity cortiz  -Properties *    |Select-Object CN,department,company,DisplayName,extensionAttribute10,extensionAttribute15,manager,UserPrincipalName,givenName,Title,Office,LastLogonDate,EmployeeID 

get-aduser -Identity KElliott  -Properties *    |Select-Object  manager,UserPrincipalName,givenName,Title,Office,description



get-aduser -Identity  ejustice -Properties * | Select-Object CN,department,company,DisplayName,extensionAttribute10,extensionAttribute15,manager,UserPrincipalName,givenName,Title,Office,LastLogonDate,EmployeeID,physicalDeliveryOfficeName,description,streetAddress
