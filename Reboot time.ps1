Function Get-Uptime {
<#
.Synopsis
    This will check how long the computer has been running and when was it last rebooted.
    For updated help and examples refer to -Online version.
 
 
.NOTES
    Name: Get-Uptime
    Author: theSysadminChannel
    Version: 1.0
    DateCreated: 2018-Jun-16
 
.LINK
    https://thesysadminchannel.com/get-uptime-last-reboot-status-multiple-computers-powershell/ -
 
 
.PARAMETER ComputerName
    By default it will check the local computer.
 
 
    .EXAMPLE
    Get-Uptime -ComputerName PAC-DC01, PAC-WIN1001
 
    Description:
    Check the computers PAC-DC01 and PAC-WIN1001 and see how long the systems have been running for.
 
#>
 
    [CmdletBinding()]
    Param (
        [Parameter(
            ValueFromPipeline=$true,
            ValueFromPipelineByPropertyName=$true,
            Position=0)]
 
        [string[]]
            $ComputerName = $env:COMPUTERNAME
    )
 
    BEGIN {}
 
    PROCESS {
        Foreach ($Computer in $ComputerName) {
            $Computer = $Computer.ToUpper()
            Try {
                $OS = Get-WmiObject Win32_OperatingSystem -ComputerName $Computer -ErrorAction Stop
                $Uptime = (Get-Date) - $OS.ConvertToDateTime($OS.LastBootUpTime)
                [PSCustomObject]@{
                    ComputerName  = $Computer
                    LastBoot      = $OS.ConvertToDateTime($OS.LastBootUpTime)
                    Uptime        = ([String]$Uptime.Days + " Days " + $Uptime.Hours + " Hours " + $Uptime.Minutes + " Minutes")
                }
 
            } catch {
                [PSCustomObject]@{
                    ComputerName  = $Computer
                    LastBoot      = "Unable to Connect"
                    Uptime        = $_.Exception.Message.Split('.')[0]
                }
 
            } finally {
                $null = $OS
                $null = $Uptime
            }
        }
    }
 
    END {}
 
}


Get-Uptime -ComputerName CSBARCHMGR
Get-Uptime -ComputerName cdap1
Get-Uptime -ComputerName CSBEXCADM01 
Get-Uptime -ComputerName sbsql2014
Get-Uptime -ComputerName devops2020
Get-Uptime -ComputerName gisportal
Get-Uptime -ComputerName gisweb05 
Get-Uptime -ComputerName gscbadge