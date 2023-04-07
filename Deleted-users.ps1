get-content C:\Users.txt | get-aduser -Properties "*" | Select-Object employeeID, cn,userPrincipalName,MemberOf,extensionAttribute10, PasswordLastSet,Description,company,department,whenChanged,msRTCSIP-UserEnabled,msExchHideFromAddressLists,mail 

