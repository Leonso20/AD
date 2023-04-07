

$pcname ='S102293'

function Get-InstalledApps {
    param (
        [Parameter(ValueFromPipeline=$true)]
        [string[]]$ComputerName = $env:COMPUTERNAME,
        [string]$NameRegex = ''
    )
    
    foreach ($comp in $ComputerName) {
        $keys = '','\Wow6432Node'
        foreach ($key in $keys) {
            try {
                $reg = [Microsoft.Win32.RegistryKey]::OpenRemoteBaseKey('LocalMachine', $comp)
                $apps = $reg.OpenSubKey("SOFTWARE$key\Microsoft\Windows\CurrentVersion\Uninstall").GetSubKeyNames()
            } catch {
                continue
            }

            foreach ($app in $apps) {
                $program = $reg.OpenSubKey("SOFTWARE$key\Microsoft\Windows\CurrentVersion\Uninstall\$app")
                $name = $program.GetValue('DisplayName')
                if ($name -and $name -match $NameRegex) {
                    [pscustomobject]@{
                        ComputerName = $comp
                        DisplayName = $name
                        DisplayVersion = $program.GetValue('DisplayVersion')
                        Publisher = $program.GetValue('Publisher')
                        InstallDate = $program.GetValue('InstallDate')
                        UninstallString = $program.GetValue('UninstallString')
                        Bits = $(if ($key -eq '\Wow6432Node') {'64'} else {'32'})
                        Path = $program.name
                    }
                }
            }
        }
    }
}

Get-InstalledApps -ComputerName $pcname  |  select DisplayName,Version  "Office*"

Get-WmiObject Win32_Product -ComputerName $pcname | select Name,Version

get-wmiobject Win32_Product -computername $pcname | Format-Table IdentifyingNumber, Name, LocalPack
age -AutoSize




Get-ADuser -Identity mflores -Properties * | select  extensionattribute15

get-wmiobject Win32_Product -computername S102723 | Format-Table IdentifyingNumber, Name, LocalPack
age -AutoSize

get-wmiobject Win32_Product -computername $pcname | Format-Table Name,  Version,Caption


Get-HotFix -PipelineVariable 'Office*' -ComputerName $pcname | ft


 $A = Get-Content -Path C:\Temp\servers.txt
 $A | ForEach-Object { if (!(Get-HotFix -Id KB3172545 -ComputerName $_))
         { Add-Content $_ -Path C:\temp\Missing.txt }}
