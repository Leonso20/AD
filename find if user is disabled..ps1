  GC C:\Temp\users.txt | % {
   get-ADUser $_  | select name,enabled, samaccountname
   }
   

   Get-ADUser -Identity CPowell | % {
   get-ADUser $_  | select name,enabled, samaccountname, DistinguishedName,GivenName,ObjectClass,ObjectClass,UserPrincipalName,PropertyNames
   }

   Get-ADUser -Identity CPowell