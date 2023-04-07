#PowerShell script for deploying software to remote computers

$Computers = Get-Content -Path "C:\ComputerList.txt"
$Software = "C:\Software\Setup.exe"

Foreach ($Computer in $Computers) {
    Invoke-Command -ComputerName $Computer -ScriptBlock {
        Start-Process -FilePath $using:Software -ArgumentList "/quiet" -Wait
    }
}
