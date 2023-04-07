Get-Mailbox AMozick@seminolecountyfl.gov | fl MaxSendSize,MaxReceiveSize

Get-Mailbox cbrandolini | fl IssueWarningQuota,ProhibitSendQuota,ProhibitSendReceiveQuota,UseDatabaseQuotaDefaults


Set-Mailbox -Identity "cbrandolini" -IssueWarningQuota 90.5gb -ProhibitSendQuota 90.5gb -ProhibitSendReceiveQuota 90.5gb -UseDatabaseQuotaDefaults $false