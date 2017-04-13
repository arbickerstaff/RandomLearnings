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

#Get SHA256 hash of file.
Get-FileHash -Path .\test.txt | Format-List

#Get MD5 hash of file.
Get-FileHash -Path .\test.txt -Algorithm MD5 | Format-List

# Get date modified of Dlists
Add-PSSnapin Microsoft.Exchange.Management.PowerShell.Admin
$list = Get-DistributionGroup -Identity * -ResultSize 5000 | select Displayname, Primarysmtpaddress, WhenChanged 
Write-Output $list | Out-GridView 

#Get MD5 hash of file.
Get-FileHash -Path C:\test.txt -Algorithm MD5 | Format-List

#Convert string to get MD5, SHA256 and SHA512 hash for string
$ConvertString = "Hello World!"
$utf8 = new-object -TypeName System.Text.UTF8Encoding
$md5 = new-object -TypeName System.Security.Cryptography.MD5CryptoServiceProvider
$sha256 = new-object -TypeName System.Security.Cryptography.SHA256CryptoServiceProvider
$sha512 = new-object -TypeName System.Security.Cryptography.SHA512CryptoServiceProvider

$md5hash = [System.BitConverter]::ToString($md5.ComputeHash($utf8.GetBytes($ConvertString)))
$sha256hash = [System.BitConverter]::ToString($sha256.ComputeHash($utf8.GetBytes($ConvertString)))
$sha512hash = [System.BitConverter]::ToString($sha512.ComputeHash($utf8.GetBytes($ConvertString)))

Write-Output $md5hash
Write-Output $sha256hash
Write-Output $sha512hash

#Convert file to get MD5, SHA256 and SHA512 hash for string
$ConvertFile = "C:\test.txt"
$md5 = new-object -TypeName System.Security.Cryptography.MD5CryptoServiceProvider
$sha256 = new-object -TypeName System.Security.Cryptography.SHA256CryptoServiceProvider
$sha512 = new-object -TypeName System.Security.Cryptography.SHA512CryptoServiceProvider

$md5hash = [System.BitConverter]::ToString($md5.ComputeHash([System.IO.File]::ReadAllBytes($ConvertFile)))
$sha256hash = [System.BitConverter]::ToString($sha256.ComputeHash([System.IO.File]::ReadAllBytes($ConvertFile)))
$sha512hash = [System.BitConverter]::ToString($sha512.ComputeHash([System.IO.File]::ReadAllBytes($ConvertFile)))

Write-Output $md5hash
Write-Output $sha256hash
Write-Output $sha512hash



### END ###
