#List users with automatic email forwarding enabled and its ForwardingAddress  emails
Get-Mailbox -Filter {ForwardingAddress -ne $null} | ft Name,ForwardingAddress,DeliverToMailboxAndForward -Autosize



#output the PrimarySMTPAddress of the recipient:
Get-Mailbox -Filter {ForwardingAddress -ne
$null} | foreach {$recipient = $_; $forwardingsmtp = (Get-Recipient $_.ForwardingAddress).PrimarySmtpAddress; Write-Host $recipient.Name, $forwardingsmtp, $recipient.DeliverToMailboxAndForward }


Get-InboxRule -mailbox mgonzalez@seminolecountyfl.gov  | fl

Get-Mailbox retireebenepayments@seminolecountyfl.gov  | select UserPrincipalName,ForwardingSmtpAddress,DeliverToMailboxAndForward

Set-Mailbox tcorn@seminolecountyfl.gov –ForwardingSmtpAddress tcorn@cfl.rr.com –DeliverToMailboxAndForward $false

Get-Mailbox -Filter {ForwardingAddress -ne $null} | select UserPrincipalName,ForwardingSmtpAddress,DeliverToMailboxAndForward



get-Mailbox mgonzalez@seminolecountyfl.gov –ForwardingSmtpAddress 3213771279@vzvmg.biz –DeliverToMailboxAndForward $false


Get-MessageTrace -SenderAddress aburgos02@seminolecountyfl.gov -RecipientAddress a2-retireebenepayments@seminolecountyfl.gov -StartDate 3/16/2023 -EndDate 03/18/2023 | where {$_.MessageTraceEventType -eq "*" -and $_.MessageSubject -like "FW:*"}

Get-MessageTrace -SenderAddress aburgos02@seminolecountyfl.gov -StartDate 3/17/2023 -EndDate 03/18/2023 | where {$_.MessageTraceEventType -eq "Deliver" -and $_.MessageSubject -like "FW:*"}


Get-Mailbox retireebenepayments@seminolecountyfl.gov | select UserPrincipalName,ForwardingSmtpAddress,DeliverToMailboxAndForward