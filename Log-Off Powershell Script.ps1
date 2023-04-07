Invoke-Command -ComputerName 'S102282.SEMCTY.NET' -ScriptBlock { quser }



#How To Remotely Log Off Specific Users using Powershel, Here is the code you will use. Just copy and paste this exactly as is into a new Powershell script.
# you will get two boxes, one for user thta want to logoff and the next one for the server where you want thatuser loff from. 

[void][Reflection.Assembly]::LoadWithPartialName('Microsoft.VisualBasic')

$PromptUser = {
        [Microsoft.VisualBasic.Interaction]::InputBox(
        ($args -join ' '),     #Prompt message
        "Log Off Remote User" #Title Bar
    )
}

$Username = &$PromptUser "Type username you wish to sign off"
$ServerName = &$PromptUser "Type target server name"
$sessionID = ((quser /server:$ServerName | Where-Object { $_ -match $UserName }) -split ' +')[2]

###logs off user
Logoff $sessionID /server:$ServerName