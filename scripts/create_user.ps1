<#
.SYNOPSIS
    Creates a Microsoft Entra ID user and assigns the user
    to the appropriate department security group.

.DESCRIPTION
    This script demonstrates IAM Joiner automation using
    Microsoft Graph PowerShell.

    Workflow:
    1. Connect to Microsoft Graph
    2. Collect new user information
    3. Check whether the user already exists
    4. Create the Entra ID user
    5. Find the appropriate department security group
    6. Add the user to the security group
    7. Display the provisioning results

.EXAMPLE
    .\create-user.ps1 `
        -FirstName "Charles" `
        -LastName "Anderson" `
        -Department "Finance" `
        -JobTitle "Financial Advisor"

.NOTES
    IAM Lab - Joiner Automation
#>

param (
    [Parameter(Mandatory = $true)]
    [string]$FirstName,

    [Parameter(Mandatory = $true)]
    [string]$LastName,

    [Parameter(Mandatory = $true)]
    [ValidateSet("IT", "HR", "Finance", "Sales", "Marketing")]
    [string]$Department,

    [Parameter(Mandatory = $true)]
    [string]$JobTitle,

    [string]$TenantDomain = "PracticeIAMLab.onmicrosoft.com"
)

# ------------------------------------------------------------
# 1. Connect to Microsoft Graph
# ------------------------------------------------------------

Write-Host ""
Write-Host "Connecting to Microsoft Graph..." -ForegroundColor Cyan

Connect-MgGraph -Scopes "User.ReadWrite.All", "Group.ReadWrite.All"

# ------------------------------------------------------------
# 2. Build User Information
# ------------------------------------------------------------

$DisplayName = "$FirstName $LastName"

$MailNickname = (
    "$FirstName.$LastName"
).ToLower() -replace '[^a-z0-9.]', ''

$UserPrincipalName = "$MailNickname@$TenantDomain"

$UsageLocation = "US"

# ------------------------------------------------------------
# 3. Map Department to Security Group
# ------------------------------------------------------------

$DepartmentGroups = @{
    "IT"        = "SG-IT-Users"
    "HR"        = "SG-HR-Users"
    "Finance"   = "SG-Finance-Users"
    "Sales"     = "SG-Sales-Users"
    "Marketing" = "SG-Marketing-Users"
}

$TargetGroupName = $DepartmentGroups[$Department]

# ------------------------------------------------------------
# 4. Check Whether User Already Exists
# ------------------------------------------------------------

Write-Host ""
Write-Host "Checking whether $UserPrincipalName already exists..." -ForegroundColor Cyan

try {
    $ExistingUser = Get-MgUser -UserId $UserPrincipalName -ErrorAction Stop

    Write-Host ""
    Write-Host "User already exists:" -ForegroundColor Yellow
    Write-Host "Display Name: $($ExistingUser.DisplayName)"
    Write-Host "UPN: $($ExistingUser.UserPrincipalName)"
    Write-Host "Object ID: $($ExistingUser.Id)"

    Write-Host ""
    Write-Host "No new user was created." -ForegroundColor Yellow

    exit
}
catch {
    Write-Host "User does not exist. Continuing with provisioning..." -ForegroundColor Green
}

# ------------------------------------------------------------
# 5. Request Temporary Password
# ------------------------------------------------------------

Write-Host ""
Write-Host "Enter a temporary password for the new user." -ForegroundColor Cyan
Write-Host "The user will be required to change it at first sign-in." -ForegroundColor Gray

$TemporaryPassword = Read-Host "Temporary Password" -AsSecureString

$PasswordText = [System.Net.NetworkCredential]::new(
    "",
    $TemporaryPassword
).Password

$PasswordProfile = @{
    Password = $PasswordText
    ForceChangePasswordNextSignIn = $true
}

# ------------------------------------------------------------
# 6. Create Entra ID User
# ------------------------------------------------------------

Write-Host ""
Write-Host "Creating Entra ID user..." -ForegroundColor Cyan

try {

    $NewUser = New-MgUser `
        -DisplayName $DisplayName `
        -GivenName $FirstName `
        -Surname $LastName `
        -UserPrincipalName $UserPrincipalName `
        -MailNickname $MailNickname `
        -AccountEnabled `
        -PasswordProfile $PasswordProfile `
        -Department $Department `
        -JobTitle $JobTitle `
        -UsageLocation $UsageLocation `
        -ErrorAction Stop

    Write-Host ""
    Write-Host "User created successfully!" -ForegroundColor Green

}
catch {

    Write-Host ""
    Write-Host "ERROR: User creation failed." -ForegroundColor Red
    Write-Host $_.Exception.Message -ForegroundColor Red

    exit
}

# ------------------------------------------------------------
# 7. Find Department Security Group
# ------------------------------------------------------------

Write-Host ""
Write-Host "Finding department security group: $TargetGroupName..." -ForegroundColor Cyan

try {

    $Group = Get-MgGroup `
        -Filter "displayName eq '$TargetGroupName'" `
        -ErrorAction Stop

    if (-not $Group) {
        throw "Security group '$TargetGroupName' was not found."
    }

    Write-Host "Group found: $($Group.DisplayName)" -ForegroundColor Green

}
catch {

    Write-Host ""
    Write-Host "ERROR: Could not find the department group." -ForegroundColor Red
    Write-Host $_.Exception.Message -ForegroundColor Red

    exit
}

# ------------------------------------------------------------
# 8. Add User to Department Security Group
# ------------------------------------------------------------

Write-Host ""
Write-Host "Adding $DisplayName to $TargetGroupName..." -ForegroundColor Cyan

try {

    $GroupMemberBody = @{
        "@odata.id" = "https://graph.microsoft.com/v1.0/directoryObjects/$($NewUser.Id)"
    }

    New-MgGroupMemberByRef `
        -GroupId $Group.Id `
        -BodyParameter $GroupMemberBody `
        -ErrorAction Stop

    Write-Host ""
    Write-Host "User successfully added to $TargetGroupName!" -ForegroundColor Green

}
catch {

    Write-Host ""
    Write-Host "ERROR: User was created, but group assignment failed." -ForegroundColor Red
    Write-Host $_.Exception.Message -ForegroundColor Red
}

# ------------------------------------------------------------
# 9. Display Provisioning Summary
# ------------------------------------------------------------

Write-Host ""
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "       IAM USER PROVISIONING COMPLETE"
Write-Host "==========================================" -ForegroundColor Cyan

Write-Host ""
Write-Host "User Information" -ForegroundColor Yellow
Write-Host "Display Name      : $($NewUser.DisplayName)"
Write-Host "First Name        : $FirstName"
Write-Host "Last Name         : $LastName"
Write-Host "UPN               : $($NewUser.UserPrincipalName)"
Write-Host "Department        : $Department"
Write-Host "Job Title         : $JobTitle"
Write-Host "Usage Location    : $UsageLocation"
Write-Host "Account Enabled   : $($NewUser.AccountEnabled)"
Write-Host "Object ID         : $($NewUser.Id)"

Write-Host ""
Write-Host "Access Assignment" -ForegroundColor Yellow
Write-Host "Security Group    : $TargetGroupName"

Write-Host ""
Write-Host "Joiner automation completed successfully." -ForegroundColor Green
Write-Host ""
