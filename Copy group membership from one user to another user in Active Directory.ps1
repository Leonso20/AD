﻿<#  
    .Synopsis  
    Copy or clone source user's member of group to another user, Copy group membership from one user to another in Active Directory.
    .Description  
    Run this script on domain controller, or install RSAT tool on your client machine. This will copy existing given users group to other give group. It validates and verify whether Source and Destination users exists or you have access.
    .Example  
    .\Copy-AdGroupMemberShip.ps1 -SourceUserGroup Administrator -DestinationUsers user1, user2, user3
        
    It takes provided Source user, note down which groups it is member of. Add same groups in the member of tabs of users list provided in parameter DestinationUsers.
    .Example
    .\Copy-AdGroupMemberShip.ps1 -SourceUser Administrator -DestinationUsers (Get-Content C:\Userlist.txt)

    Users list can be provided into text file.
    .Example
    user1, user2, user3 | .\Copy-AdGroupMemberShip.ps1 -SourceUser Administrator

    .Notes
    NAME: Copy-AdGroupMemberShipGui
    AUTHOR: Kunal Udapi
    CREATIONDATE: 5 February 2019
    LASTEDIT: 6 February 2019
    KEYWORDS: Copy or clone source user's member of group to another user.
    .Link  
    #Check Online version: http://kunaludapi.blogspot.com
    #Check Online version: http://vcloud-lab.com
    #Requires -Version 3.0  
    #>  
  

   #requires -Version 3 

   #Load required libraries
   Add-Type -AssemblyName PresentationFramework, PresentationCore, WindowsBase, System.Windows.Forms, System.Drawing, System.Windows.Forms

   function Show-MessageBox {   
    param (   
      [string]$Message = "Show user friendly Text Message",   
      [string]$Title = 'Title here',   
      [ValidateRange(0,5)]   
      [Int]$Button = 0,   
      [ValidateSet('None','Hand','Error','Stop','Question','Exclamation','Warning','Asterisk','Information')]   
      [string]$Icon = 'Error'   
    )   
    #Note: $Button is equl to [System.Enum]::GetNames([System.Windows.Forms.MessageBoxButtons])   
    #Note: $Icon is equl to [System.Enum]::GetNames([System.Windows.Forms.MessageBoxIcon])   
    $MessageIcon = [System.Windows.Forms.MessageBoxIcon]::$Icon   
    [System.Windows.Forms.MessageBox]::Show($Message,$Title,$Button,$MessageIcon)   
  }  

  Function Confirm-AD {  
    $AllModules = Get-Module -ListAvailable ActiveDirectory  
    if (!$AllModules) {  
        Show-MessageBox -Message 'Install RSAT tool or AD Management tools' -Title 'Missing Ad tools' -Icon Error | Out-Null
    }
    else {
      Import-Module ActiveDirectory
    }
    $progressBar.Value = 10
  }

  function Show-FileBrowser {
    $openFileBrowser = New-Object System.Windows.Forms.OpenFileDialog
    $openFileBrowser.Title = 'Open txt file with users list'
    $openFileBrowser.InitialDirectory = 'C:\' #[Environment]::GetFolderPath('SystemDrive') 
    #$openFileBrowser.CheckFileExists = $true
    $openFileBrowser.CheckPathExists = $true
    $openFileBrowser.Filter =  "Text files (*.txt)|*.txt|All files (*.*)|*.*" #'Documents (*.docx)|*.docx|SpreadSheet (*.xlsx)|*.xlsx'
    $null = $OpenFileBrowser.ShowDialog()
    
    $openFileBrowser.FileName
    $progressBar.Value = 20
  }

[xml]$xaml = @"
<Window 
    xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
    xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
    xmlns:d="http://schemas.microsoft.com/expression/blend/2008"
    xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
    xmlns:local="clr-namespace:WpfApp2"

    Title="Copy AD user group membership - Launch as Administrator" Height="245" Width="800" ResizeMode="NoResize">
<Grid>
    <TextBlock x:Name="textBlockSourceUser" HorizontalAlignment="Left" Margin="10,10,0,0" TextWrapping="Wrap" Text="Source user:" VerticalAlignment="Top"/>
    <TextBox x:Name="textBoxSourceUser" HorizontalAlignment="Left" Height="23" Margin="79,9,0,0" TextWrapping="Wrap" Text="Administrator" VerticalAlignment="Top" Width="165" Background="LightCoral"/>
    <Button x:Name="buttonSourceGroupList" Content="Source Groups List" HorizontalAlignment="Left" Margin="130,37,0,0" VerticalAlignment="Top" Width="114" Height="23"/>
    <ListBox x:Name="listBoxSourceUserGroups" HorizontalAlignment="Left" Margin="10,65,0,0" Width="234" Height="87" VerticalAlignment="Top" Background="KHAKI"/>
    <TextBlock x:Name="textBlockDestinationUsers" HorizontalAlignment="Left" Margin="249,10,0,0" TextWrapping="Wrap" Text="Destination Users list:" VerticalAlignment="Top"/>
    <TextBox x:Name="textBoxDestinationUsersList" Height="95" Margin="249,37,307,0" TextWrapping="Wrap" Text="Load List from txt file" VerticalAlignment="Top" AcceptsReturn="True" HorizontalScrollBarVisibility="Disabled" VerticalScrollBarVisibility="Auto" IsReadOnly='True' Background="KHAKI"/>
    <Button x:Name="buttonVerifyUserList" Content="Verify Users in AD" Margin="357,0,307,59" VerticalAlignment="Bottom" Height="23" IsEnabled="False"/>
    <Button x:Name="buttonLoadFromTxt" Content="Load from TXT" Margin="389,10,307,0" VerticalAlignment="Top" Height="23" IsEnabled='False'/>
    <Button x:Name="buttonCopyMemberGroups" Content="Copy-AdMemberShip" Margin="357,0,307,22" VerticalAlignment="Bottom" Height="23" IsEnabled="False"/>
    <ProgressBar x:Name="progressBar" Height="23" Margin="140,0,0,22" VerticalAlignment="Bottom" HorizontalAlignment="Left" Width="212"/>
    <Label x:Name="webSite" Content="http://vcloud-lab.com" HorizontalAlignment="Left" Margin="10,0,0,19" VerticalAlignment="Bottom" Foreground="Blue" ToolTip="http://vcloud-lab.com"/>
    <TextBox x:Name="textBoxLogs" HorizontalAlignment="Right" Margin="0,10,10,22" TextWrapping="Wrap" Text="Logs" Width="292" IsReadOnly="True" Background="DARKKHAKI" VerticalScrollBarVisibility="Visible"/>

</Grid>
</Window>
"@

#Read the form
$Reader = (New-Object System.Xml.XmlNodeReader $xaml) 
$Form = [Windows.Markup.XamlReader]::Load($reader) 

#AutoFind all controls
$xaml.SelectNodes("//*[@*[contains(translate(name(.),'n','N'),'Name')]]")  | ForEach-Object { 
New-Variable  -Name $_.Name -Value $Form.FindName($_.Name) -Force 
}

#Website url
#$uri = {[system.Diagnostics.Process]::start('http://vcloud-lab.com')}
#$webSite.Add_PreviewMouseDown($uri)
$webSite.Add_MouseLeftButtonUp({[system.Diagnostics.Process]::start('http://vcloud-lab.com')})
$webSite.Add_MouseEnter({$webSite.Foreground = 'Purple'})
$webSite.Add_MouseLeave({$webSite.Foreground = 'Blue'})

$buttonSourceGroupList.Add_Click({
    Confirm-AD
    $textBoxLogs.Text = "Verifying Source User '{0}' in AD" -f $textBoxSourceUser.Text
    try 
    {
        $Global:sourceUserMemberOf = Get-AdUser $textBoxSourceUser.Text -Properties MemberOf -ErrorAction Stop
        $listBoxSourceUserGroups.ItemsSource = $sourceUserMemberOf.MemberOf | ForEach-Object {(($_ -split 'CN=') -split ',')[1]}
        $buttonLoadFromTxt.IsEnabled = $true
        $textBoxLogs.Text = "{0}`nVerified user '{1}' exist in AD" -f $textBoxLogs.Text, $textBoxSourceUser.Text
    }
    catch 
    {
        Write-Host -BackgroundColor DarkRed -ForegroundColor White $Error[0].Exception.Message
        $textBoxLogs.Text = "{0}`nProvide valid user,'{1}' doesn't exist in AD" -f $textBoxLogs.Text, $textBoxSourceUser.Text
        #Break
    }
})

$buttonLoadFromTxt.Add_Click({
    $fileName = Show-FileBrowser
    $textBoxLogs.Text = "{0}`n==============================" -f $textBoxLogs.Text
    if (-not([System.String]::IsNullOrWhiteSpace($fileName))) { #[string]::IsNullOrEmpty($fileName)
        $Global:fileContents = Get-Content -Path $fileName 
        $listOfUsers = $fileContents | ForEach-Object {"`r`n$_"}
        #$textBoxDestinationUsersList.Text = $null
        $textBoxDestinationUsersList.Text = $listOfUsers[0..$listOfUsers.Length]
        $buttonVerifyUserList.IsEnabled = $true
        $textBoxLogs.Text = "{0}`nSelected file name '{1}'" -f $textBoxLogs.Text, $fileName
    }
    else {
        Write-Host 'Please select text file' -BackgroundColor DarkRed
        $textBoxLogs.Text = "{0}`nNo Text file selected" -f $textBoxLogs.Text
    }
})

$buttonVerifyUserList.Add_Click({
    $Global:confirmedUserList = @()
    $textBoxLogs.Text = "{0}`n==============================" -f $textBoxLogs.Text
    foreach ($user in ($textBoxDestinationUsersList.Text -split ' ').trim())
    {
        try 
        {
            $textBoxLogs.Text = "{0}`nChecking user '{1}' status in AD" -f $textBoxLogs.Text, $user
            Write-Host -BackgroundColor DarkGray "Checking user '$user' status in AD..." -NoNewline
            [void](Get-ADUser $user -ErrorAction Stop)
            Write-Host -BackgroundColor DarkGreen -ForegroundColor White "...Tested user '$user' exist in AD"
            $textBoxLogs.Text = "{0}`nTested user '{1}' exist in AD" -f $textBoxLogs.Text, $user
            $buttonCopyMemberGroups.IsEnabled = $true
            $Global:confirmedUserList += $user
        }
        catch [Microsoft.ActiveDirectory.Management.ADIdentityNotFoundException]
        {
            Write-Host -BackgroundColor DarkRed -ForegroundColor White "...User '$user' doesn't exist in AD"
            $textBoxLogs.Text = "{0}`nUser '{1}' doesn't exist in AD" -f $textBoxLogs.Text, $user
        } #catch [Microsoft.ActiveDirectory.Management.ADIdentityNotFoundException]
        catch 
        {
            Write-Host -BackgroundColor DarkRed -ForegroundColor White "...Check your access"
            $textBoxLogs.Text = "{0}`nCheck your access on user '{1}'" -f $textBoxLogs.Text, $user
        } #catch
    } #foreach ($user in $destinationUser)

    $textBoxDestinationUsersList.Text = $confirmedUserList | ForEach-Object {"`n$_"}
    $progressBar.Value = 50
})

$buttonCopyMemberGroups.Add_Click({
    $textBoxLogs.Text = "{0}`n==============================" -f $textBoxLogs.Text
    foreach ($group in $sourceUserMemberOf.MemberOf) 
    {
        try 
        {
            $Global:groupInfo = Get-AdGroup $group
            $groupName = $groupInfo.Name
            $groupInfo | Add-ADGroupMember -Members $confirmedUserList -ErrorAction Stop
            Write-Host -BackgroundColor DarkGreen "Added users to group '$groupName'"
            $textBoxLogs.Text = "{0}`nAdded users to group '{1}' " -f $textBoxLogs.Text, $groupName
        } #try

        catch
        {
            #$Error[0].Exception.GetType().fullname
            if ($null -eq $confirmedUserList[0]) {
                Write-Host -BackgroundColor DarkMagenta "Provided destination user list is invalid, Please Try again."
                $textBoxLogs.Text = "{0}`nProvided destination users list is invalid " -f $textBoxLogs.Text
                #break
            }
            Write-Host -BackgroundColor DarkMagenta $groupName - $($Error[0].Exception.Message)
            $textBoxLogs.Text = "{0}`n{1} - {2} " -f $textBoxLogs.Text, $groupName, $Error[0].Exception.Message
        } #catch
    } #foreach ($group in $sourceUserMemberOf.MemberOf)
    $progressBar.Value = 100
})

#Mandetory last line of every script to load form
[void]$Form.ShowDialog()