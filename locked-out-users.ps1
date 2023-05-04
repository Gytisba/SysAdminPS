# PowerShell script to find locked-out users in your Active Directory
# Import the Active Directory module if it's not already loaded
if (-not (Get-Module -Name ActiveDirectory)) {
    Import-Module ActiveDirectory
}

# Function to find locked-out users in Active Directory
function Get-LockedOutUsers {
    $LockedOutUsers = Search-ADAccount -LockedOut

    if ($LockedOutUsers.Count -eq 0) {
        Write-Host "No locked-out users found." -ForegroundColor Green
    } else {
        Write-Host "Locked-out users found:" -ForegroundColor Red

        $table = $LockedOutUsers | Select-Object Name, SamAccountName, LockedOut, DistinguishedName
        $table | Format-Table -AutoSize
    }
}

# Call the function to find locked-out users
Get-LockedOutUsers
