Function Get-RebootHistory {
<#
.SYNOPSIS
    This will output who initiated a reboot or shutdown event.
 
.NOTES
    Name: Get-RebootHistory
    Author: theSysadminChannel
    Version: 1.0
    DateCreated: 2020-Aug-5
 
.LINK
    https://thesysadminchannel.com/get-reboot-history-using-powershell -
 
.EXAMPLE
    Get-RebootHistory -ComputerName Server01, Server02
 
.EXAMPLE
    Get-RebootHistory -DaysFromToday 30 -MaxEvents 1
 
.PARAMETER ComputerName
    Specify a computer name you would like to check.  The default is the local computer
 
.PARAMETER DaysFromToday
    Specify the amount of days in the past you would like to search for
 
.PARAMETER MaxEvents
    Specify the number of events you would like to search for (from newest to oldest)
#>
 
 
    [CmdletBinding()]
    param(
        [Parameter(
            Mandatory = $false,
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true
        )]
        [string[]]  $ComputerName = $env:COMPUTERNAME,
 
        [int]       $DaysFromToday = 7,
 
        [int]       $MaxEvents = 9999
    )
 
    BEGIN {}
 
    PROCESS {
        foreach ($Computer in $ComputerName) {
            try {
                $Computer = $Computer.ToUpper()
                $EventList = Get-WinEvent -ComputerName $Computer -FilterHashtable @{
                    Logname = 'system'
                    Id = '1074', '6008'
                    StartTime = (Get-Date).AddDays(-$DaysFromToday)
                } -MaxEvents $MaxEvents -ErrorAction Stop
 
 
                foreach ($Event in $EventList) {
                    if ($Event.Id -eq 1074) {
                        [PSCustomObject]@{
                            TimeStamp    = $Event.TimeCreated
                            ComputerName = $Computer
                            UserName     = $Event.Properties.value[6]
                            ShutdownType = $Event.Properties.value[4]
                        }
                    }
 
                    if ($Event.Id -eq 6008) {
                        [PSCustomObject]@{
                            TimeStamp    = $Event.TimeCreated
                            ComputerName = $Computer
                            UserName     = $null
                            ShutdownType = 'unexpected shutdown'
                        }
                    }
 
                }
 
            } catch {
                Write-Error $_.Exception.Message
 
            }
        }
    }
 
    END {}
}


Get-RebootHistory -computername csbadfs -DaysFromToday 30 -MaxEvents 1


########################################################################################################################################################################

Get-RebootHistory -ComputerName csbadfs


#######################################################################################################################################################################

invoke-command {get-eventlog -LogName System} -ComputerName spsql


#######################################################################################################################################################################

invoke-command {$Begin = Get-Date -Date ‘11/11/2022 05:00:00’

$End = Get-Date -Date ‘11/12/2022 17:00:00’

Get-EventLog -LogName System -EntryType Warning -After $Begin -Before $End} -ComputerName spsql

########################################################################################################################################################################
invoke-command {$Begin = Get-Date -Date ‘11/11/2022 05:00:00’

$End = Get-Date -Date ‘11/12/2022 17:00:00’

Get-EventLog -LogName System  -After $Begin -Before $End} -ComputerName spsql

#######################################################################################################################################################################

invoke-command {Get-EventLog -LogName System -Message *description*} -ComputerName csbadfs

1074



invoke-command {Get-EventLog -LogName “Windows Powershell” -Source PowerShell | Where-Object {$_.EventID -eq 6008
} | Select-Object -Property Source, EventID, InstanceId, Message} -ComputerName csbadfs |FT


