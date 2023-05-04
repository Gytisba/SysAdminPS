#PowerShell script to find inactive users in your Active Directory based on the last logon date

# Import the Active Directory module if it's not already loaded
if (-not (Get-Module -Name ActiveDirectory)) {
    Import-Module ActiveDirectory
}

# Function to find inactive users in Active Directory
function Get-InactiveUsers {
    $DaysInactive = 90
    $InactiveDate = (Get-Date).AddDays(-$DaysInactive)

    $InactiveUsers = Get-ADUser -Filter {LastLogonTimeStamp -lt $InactiveDate -and enabled -eq $true} -Properties LastLogonTimeStamp

    if ($InactiveUsers.Count -eq 0) {
        Write-Host "No inactive users found." -ForegroundColor Green
    } else {
        Write-Host "Inactive users found:" -ForegroundColor Red

        $table = $InactiveUsers | Select-Object Name, SamAccountName, @{Name="LastLogonDate"; Expression={[datetime]::FromFileTime($_.LastLogonTimeStamp).ToString("yyyy-MM-dd")}}, DistinguishedName
        $table | Format-Table -AutoSize
    }
}

# Call the function to find inactive users
Get-InactiveUsers
