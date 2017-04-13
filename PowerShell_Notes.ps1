# Load Active Directory
Import-Module ActiveDirectory

# Load Exchange 2007
Add-PSSnapin Microsoft.Exchange.Management.PowerShell.Admin

# Export all accounts and properties from input
foreach ($entry in $list) {
    $information = Get-ADUser -Identity $entry.samAccountName -Properties *
    Write-Output ($information) | Out-File $File -Append
}

# Export all accounts username and password last set information.
foreach ($entry in $list) {
    $PasswordLastSet = (Get-ADUser -Identity $entry.samAccountName -Properties PasswordLastSet).PasswordLastSet
    Write-output ($entry.samAccountName + "   |  " + $PasswordLastSet) | Out-File $File -Append
}

# Set timelaps for target of script.
$DaysInactive = 28  
$time = (Get-Date).Adddays(-($DaysInactive))

# Prompt for entry of details and store in variable.
$UserNameEntry = Read-Host -Prompt 'Enter Username'

# Convert file to Base64 encoding
$content = get-content -path C:\image.png -encoding byte
$base64 = [System.Convert]::ToBase64String($content)
$base64 | Out-File C:\encoded.txt

