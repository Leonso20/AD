
<#export all disabled users to an Excel file. Here is a sample script. t will export all disabled users to an Excel file.
 Just make sure to modify the $filename variable to specify the desired directory and filename where you want to save the Excel file.#>



# Import ActiveDirectory module
Import-Module ActiveDirectory

# Get all disabled users
$disabledUsers = Get-ADUser -Filter {Enabled -eq $false}

# Create a new Excel file
$excel = New-Object -ComObject Excel.Application
$workbook = $excel.Workbooks.Add()
$worksheet = $workbook.Worksheets.Item(1)
$worksheet.Cells.Item(1,1) = "Disabled Users"

# Add headers to the Excel file
$worksheet.Cells.Item(2,1) = "Name"
$worksheet.Cells.Item(2,2) = "SamAccountName"
$worksheet.Cells.Item(2,3) = "Email"
$worksheet.Cells.Item(2,4) = "Description"

# Add disabled users to the Excel file
$row = 3
foreach ($user in $disabledUsers) {
    $worksheet.Cells.Item($row,1) = $user.Name
    $worksheet.Cells.Item($row,2) = $user.SamAccountName
    $worksheet.Cells.Item($row,3) = $user.EmailAddress
    $worksheet.Cells.Item($row,4) = $user.Description
    $row++
}

# Save the Excel file
$filename = "C:\Users\ea6\Documents\DisabledUsers.xlsx"
if (Test-Path $filename) {
    Remove-Item $filename -Force
}
$worksheet.SaveAs($filename)

# Close the Excel file
$workbook.Close()
$excel.Quit()
