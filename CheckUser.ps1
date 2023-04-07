<# --------------------------------------------------------------------------------------------
   Title: AD User Checker 1.0
   Author: Carly Salali Germany
   Version: 1.0 (beta)
   Date Created : 10/15/2019
   Last Modified: 10/15/2019
   Description: Check AD User stats and alert to space in UPN or missing attributes or field data.

------------------------------------------------------------------------------------------------- #>

<#
     To fix clipboard issues:
     1. Kill the process rdpclip.exe using the task manager in the remote computer
     2. Go to RUN command and start the application rdpclip.exe
#>

<# ---------------------------------------------------------------------------------------------- #>

function Test_Variable_Values($Field_Value)
{ 
         $MaxVerbosity = $false;

         $The_Message = "";

         if($Field_Value -eq $null)
         {
             $The_Message = "Field is NULL.`n";
         }
         elseif($Field_Value -eq "")
         {
             $The_Message = "Field is not NULL, but contains NO value.`n";
         }
         else
         { 
             $StringArray = $Field_Value.ToCharArray();

             if($MaxVerbosity -eq $true)
             {
                 Write("There is something there.");
                 Write("Looking for whitespace");
                 Write("The variable contains " + ($StringArray.Count) + " characters.`n");
             }

             for($x = 0; $x -lt $StringArray.Count; $x++)
             {
                 if($StringArray[$x] -eq " ")
                 {
                     $The_Message = "Whitespace detected!!! In character: " + ($x+1) + ".`n";
                     break;
                 }
                 else
                 {
                     if($MaxVerbosity -eq $true)
                     {  Write("Testing: " + $StringArray[$x] + " is not whitespace."); }
                 }
             }
         }

         return $The_Message;
}

<# ---------------------------------------------------------------------------------------------- #>

function Main_Menu
{
         Clear;
         $User_Object;
         $Quit = "false";

         Write("`n");

         for($LOOP = "GO"; $LOOP -NE "STOP"; $LOOP = $LOOP)
         {
             Write("     --------- Target User By ------");
             Write("     |                             |");
             Write("     |    (S)AM Account Name       |");
             Write("     |    (U)ser Principal Name    |");
             Write("     |    (D)isplay Name           |");
             Write("     |    (E)mployee ID            |");
             Write("     |    (X) Exit                 |");
             Write("     |                             |");
             Write("     -------------------------------");
             Write("");

            switch(Read-Host "     Choose")
            { 
                s {   Clear; 
                      $The_User = Read-Host("`nEnter User Sam Account");
                      $User_Object = Get-ADUser $The_User -Properties *;
                      Check_User($User_Object);
                      break;
                  };
                u {   Clear; 
                      $The_User = Read-Host("`nEnter User UPN");
                      $User_Object = Get-ADUser -Filter { UserPrincipalName -like $The_User } -Properties *;
                      Check_User($User_Object)
                      break;
                  }

                d {   Clear; 
                      $The_User = Read-Host("`nEnter User Display Name");
                      $User_Object = Get-ADUser -Filter { Name -like $The_User } -Properties *;
                      Check_User($User_Object)
                      break;
                  };

                e {   Clear; 
                      $The_User = Read-Host("`nEnter User Employee ID");
                      $User_Object = Get-ADUser -Filter { EmployeeID -like $The_User } -Properties *;
                      Check_User($User_Object)
                      break;;
                  };

                x {  Write-Host("`n`n     Exiting ...") -foregroundcolor "Red"; 
                     $LOOP = "STOP";
                     $Quit = "true";
                     break;
                  };

                default {  Clear; 
                           Write-Host("`n`n     Invalid entry!");
                        };

           }#close switch 

         }#close for
}

<# ---------------------------------------------------------------------------------------------- #>

function Check_User($User_Object)
{
         Write("`n-----General Details-------------------------------------------------");
         Write("UPN: " + $User_Object.UserPrincipalName);
         
         $Result = Test_Variable_Values -Field_Value $User_Object.UserPrincipalName;
         if($Result -LIKE "*Whitespace*" -OR $Result -LIKE "*NULL*")
         {  Write-Host("Warning!") -ForegroundColor Red $Result;  }

         Write("Display Name: " + $User_Object.DisplayName);
         Write("Name (alias): " + $User_Object.Name);
         Write("First Name: " + $User_Object.GivenName);
         Write("Last Name: " + $User_Object.Surname);
         Write("SAM Account: " + $User_Object.SamAccountName);
         
         $Result = Test_Variable_Values -Field_Value $User_Object.SamAccountName;
         if($Result -LIKE "*Whitespace*" -OR $Result -LIKE "*NULL*")
         {  Write-Host("Warning!") -ForegroundColor Red $Result;  }

         Write("Enabled: " + $User_Object.Enabled);
         Write("Employee ID: " + $User_Object.EmployeeID);

         $Result = Test_Variable_Values -Field_Value $User_Object.EmployeeID;
         if($Result -LIKE "*Whitespace*" -OR $Result -LIKE "*NULL*")
         {  Write-Host("Warning!") -ForegroundColor Red $Result;  }

         Write("EMail: " + $User_Object.EmailAddress);

         $Result = Test_Variable_Values -Field_Value $User_Object.EmailAddress;
         if($Result -LIKE "*Whitespace*" -OR $Result -LIKE "*NULL*")
         {  Write-Host("Warning!") -ForegroundColor Red $Result;  }

         Write("Extension Attribute 1: " + $User_Object.extensionAttribute1);
         if($User_Object.extensionAttribute1 -LIKE " " -OR $User_Object.extensionAttribute1 -EQ $null)
         {  Write-Host("Warning! Field 1 is empty.") -ForegroundColor Red;  }
         elseif($User_Object.extensionAttribute1 -NE "Staff" -AND $User_Object.extensionAttribute1 -NE "Student")
         { Write-Host("Warning! Field 1 is neither `"Staff`" nor `"Student`". Are you sure?") -ForegroundColor Red; }

         Write("Extension Attribute 5: " + $User_Object.extensionAttribute5);
         Write("Extension Attribute 6: " + $User_Object.extensionAttribute6);
         Write("Extension Attribute 7: " + $User_Object.extensionAttribute7);
         Write("Extension Attribute 8: " + $User_Object.extensionAttribute8);
         Write("Extension Attribute 9: " + $User_Object.extensionAttribute9);
         Write("Extension Attribute 10: " + $User_Object.extensionAttribute10);
         Write("Extension Attribute 11: " + $User_Object.extensionAttribute11);
         Write("Extension Attribute 12: " + $User_Object.extensionAttribute12);

         Write("`n-----Location Details-------------------------------------------------");
         Write("Account location: " + $User_Object.DistinguishedName);
         Write("Account created: " + $User_Object.Created);
         Write("Home Directory: " + $User_Object.HomeDirectory);
         Write("Home Directory Mapped To: " + $User_Object.HomeDrive);
         Write("Supervisor: " + $User_Object.Manager);
         
         Write("`n-----Group Membership------------------------------------------------");
         Write("Managed: " + $User_Object.managedObjects);

         $TargetGroups = $User_Object.MemberOf;

         Write-Host("`nGroup Membership: " + $TargetGroups.Count);

         for($a = -0; $a -LT $TargetGroups.Count; $a++)
         { 
              Write-Host("     " + ($a+1) + ". " + $TargetGroups[$a]);
         }



         Write("`n-----Status Details-------------------------------------------------");
         Write("Password Expired: "+ $User_Object.PasswordExpired);
         Write("Password Changed: "+ $User_Object.PasswordLastSet);
         Write("Last Bad Password: " + $User_Object.LastBadPasswordAttempt);
         #Write("BAD Logon Count: " + $User_Object.BadLogonCount);
         Write("Account LOCKED: " + $User_Object.LockedOut);
         Write("Account Lockout Time: " + $User_Object.AccountLockoutTime);
         Write("Bad Password Count: " + $User_Object.BadPwdCount);
         Write("Last Log On:" + $User_Object.LastLogonDate);
         Write("Password Set to `"Never Expires`": " + $User_Object.PasswordNeverExpires);
         Write("Password Set to `"Not Required`": " + $User_Object.PasswordNotRequired);         
         Write("Account Last Modified: "+ $User_Object.Modified);
         Write("Account Changed: "+ $User_Object.whenChanged);
         Write("Account Created: "+ $User_Object.whenCreated);

         $ExpDate = $User_Object.AccountExpirationDate;
         if($ExpDate -EQ $null) { $ExpDate = "Never" }
         Write("Account Expires: " + $ExpDate);

         Write("`n-----Contact Details-------------------------------------------------");
         Write("Department: "+ $User_Object.Department);
         Write("Company: "+ $User_Object.Company);
         Write("Job Title: "+ $User_Object.Title);
         Write("Description: "+ $User_Object.Description);

         Write("Phone: "+ $User_Object.OfficePhone);
         Write("Street: "+ $User_Object.StreetAddress);
         Write("State: "+ $User_Object.State);
         Write("Post Code: "+ $User_Object.PostalCode);
         
         Write("`n-----Other Details-------------------------------------------------");
         Write("GUID : "+ $User_Object.ObjectGUID);
         Write("SID : "+ $User_Object.SID);


         switch(Read-Host "`n`nEnter ANYTHING to continue.")         {              default {                           Clear;                          Write-Host("`n`n Exiting to Main Menu...`n`n") -foregroundcolor "Red";                          break;                       };         }

         #Get Lockout Info from Logs
         #Get-EventLog -LogName "Security" -ComputerName "AD_Server" -After (Get-Date).AddDays(-1) -InstanceID "4740" | Select TimeGenerated, ReplacementString
}

<# ---------------------------------------------------------------------------------------------- #>

Set-AdUser 857027 -PasswordNotRequired $false;




#Get user by employeeID
#Get-ADUser -filter 'employeeID -EQ 470554'


#Function Invocations
Main_Menu;


#Get-ADDefaultDomainPasswordPolicy


         <#
             #Split string into multiples where whitespace
             $string = "This is my test string"
             $array = $string -split "\s+"
             $array
         #>



         <#
Get-ADUser -Properties Name,distinguishedname,useraccountcontrol,objectClass -LDAPFilter "(&(userAccountControl:1.2.840.113556.1.4.803:=32)(!(IsCriticalSystemObject=TRUE)))" -SearchBase "$domainDN" | select SamAccountName,Name,useraccountcontrol,distinguishedname >C:\admin\PwNotReq.txt
         #>