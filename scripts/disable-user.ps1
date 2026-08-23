<#
.SYNOPSIS
    Disables a Microsoft Entra ID user and removes department
    security group memberships.

.DESCRIPTION
    This script demonstrates IAM Leaver automation using
    Microsoft Graph PowerShell.

    Workflow:
    1. Connect to Microsoft Graph
    2. Locate the user
    3. Display current account information
    4. Disable the user account
    5. Revoke active sessions
    6. Remove the user from IAM department groups
    7. Verify the account is disabled
    8. Display the deprovisioning results

.EXAMPLE
    .\disable-user.ps1 -UserPrincipalName "alex.johnson@yourtenant.onmicrosoft.com"

.NOTES
    IAM Lab - Leaver Automation
#>

param (
    [Parameter(Mandatory = $true)]
    [string]$UserPrincipalName
)

# ------------------------------------------------------------
# 1. Connect to Microsoft Graph
# ------------------------------------------------------------

Write-Host ""
Write-Host "Connecting to Microsoft Graph..." -ForegroundColor Cyan

Connect-MgGraph `
    -Scopes "User.ReadWrite.All", "Group.ReadWrite.All"

# ------------------------------------------------------------
# 2. Define IAM Security Groups
# ------------------------------------------------------------

$DepartmentGroups = @(
    "SG-IT-Users"
    "SG-HR-Users"
    "SG-Finance-Users"
    "SG-Sales-Users"
    "SG-Marketing-Users"
)

# ------------------------------------------------------------
# 3. Find User
# ------------------------------------------------------------

Write-Host ""
Write-Host "Searching for user: $UserPrincipalName..." -ForegroundColor Cyan

try {

    $User = Get-MgUser `
        -UserId $UserPrincipalName `
        -Property Id,DisplayName,UserPrincipalName,Department,JobTitle,AccountEnabled `
        -ErrorAction Stop

}
catch {

    Write-Host ""
    Write-Host "ERROR: User could not be found." -ForegroundColor Red
    Write-Host $_.Exception.Message -ForegroundColor Red

    exit
}

# ------------------------------------------------------------
# 4. Display Current User Information
# ------------------------------------------------------------

Write-Host ""
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "          CURRENT USER INFORMATION"
Write-Host "==========================================" -ForegroundColor Cyan

Write-Host ""
Write-Host "Display Name    : $($User.DisplayName)"
Write-Host "UPN             : $($User.UserPrincipalName)"
Write-Host "Department      : $($User.Department)"
Write-Host "Job Title       : $($User.JobTitle)"
Write-Host "Account Enabled : $($User.AccountEnabled)"
Write-Host "Object ID       : $($User.Id)"

# ------------------------------------------------------------
# 5. Check Whether Account Is Already Disabled
# ------------------------------------------------------------

if ($User.AccountEnabled -eq $false) {

    Write-Host ""
    Write-Host "Account is already disabled." -ForegroundColor Yellow

}
else {

    # --------------------------------------------------------
    # 6. Disable User Account
    # --------------------------------------------------------

    Write-Host ""
    Write-Host "Disabling user account..." -ForegroundColor Cyan

    try {

        Update-MgUser `
            -UserId $User.Id `
            -AccountEnabled:$false `
            -ErrorAction Stop

        Write-Host ""
        Write-Host "User account disabled successfully." -ForegroundColor Green

    }
    catch {

        Write-Host ""
        Write-Host "ERROR: Failed to disable user account." -ForegroundColor Red
        Write-Host $_.Exception.Message -ForegroundColor Red

        exit
    }
}

# ------------------------------------------------------------
# 7. Revoke Active Sessions
# ------------------------------------------------------------

Write-Host ""
Write-Host "Revoking active sessions..." -ForegroundColor Cyan

try {

    Revoke-MgUserSignInSession `
        -UserId $User.Id `
        -ErrorAction Stop

    Write-Host ""
    Write-Host "Active sessions revoked successfully." -ForegroundColor Green

}
catch {

    Write-Host ""
    Write-Host "WARNING: Could not revoke active sessions." -ForegroundColor Yellow
    Write-Host $_.Exception.Message -ForegroundColor Yellow

}

# ------------------------------------------------------------
# 8. Find Department Group Memberships
# ------------------------------------------------------------

Write-Host ""
Write-Host "Checking IAM security group memberships..." -ForegroundColor Cyan

try {

    $UserGroups = Get-MgUserMemberOf `
        -UserId $User.Id `
        -All `
        -ErrorAction Stop

}
catch {

    Write-Host ""
    Write-Host "ERROR: Could not retrieve group memberships." -ForegroundColor Red
    Write-Host $_.Exception.Message -ForegroundColor Red

    exit
}

# ------------------------------------------------------------
# 9. Remove User From IAM Security Groups
# ------------------------------------------------------------

foreach ($GroupName in $DepartmentGroups) {

    $Group = Get-MgGroup `
        -Filter "displayName eq '$GroupName'" `
        -ErrorAction SilentlyContinue

    if ($Group) {

        $IsMember = $UserGroups | Where-Object {
            $_.Id -eq $Group.Id
        }

        if ($IsMember) {

            Write-Host ""
            Write-Host "Removing user from $GroupName..." -ForegroundColor Cyan

            try {

                Remove-MgGroupMemberDirectoryObjectByRef `
                    -GroupId $Group.Id `
                    -DirectoryObjectId $User.Id `
                    -ErrorAction Stop

                Write-Host "Removed from $GroupName." -ForegroundColor Green

            }
            catch {

                Write-Host ""
                Write-Host "WARNING: Could not remove user from $GroupName." -ForegroundColor Yellow
                Write-Host $_.Exception.Message -ForegroundColor Yellow
            }

        }
    }
}

# ------------------------------------------------------------
# 10. Verify Account Status
# ------------------------------------------------------------

Write-Host ""
Write-Host "Verifying account status..." -ForegroundColor Cyan

$UpdatedUser = Get-MgUser `
    -UserId $User.Id `
    -Property DisplayName,UserPrincipalName,Department,JobTitle,AccountEnabled

# ------------------------------------------------------------
# 11. Display Final Results
# ------------------------------------------------------------

Write-Host ""
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "       IAM LEAVER PROCESS COMPLETE"
Write-Host "==========================================" -ForegroundColor Cyan

Write-Host ""
Write-Host "User Information" -ForegroundColor Yellow
Write-Host "Display Name    : $($UpdatedUser.DisplayName)"
Write-Host "UPN             : $($UpdatedUser.UserPrincipalName)"
Write-Host "Department      : $($UpdatedUser.Department)"
Write-Host "Job Title       : $($UpdatedUser.JobTitle)"
Write-Host "Account Enabled : $($UpdatedUser.AccountEnabled)"

Write-Host ""
Write-Host "Actions Completed" -ForegroundColor Yellow
Write-Host "Account Disabled : $($UpdatedUser.AccountEnabled -eq $false)"
Write-Host "Sessions Revoked : Yes"
Write-Host "Group Access     : IAM department groups removed"

Write-Host ""
Write-Host "Leaver automation completed." -ForegroundColor Green
Write-Host ""
