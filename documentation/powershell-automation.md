# PowerShell IAM Automation

## Overview

This lab demonstrates automated identity lifecycle management
using Microsoft Graph PowerShell.

The automation covers:

- User provisioning
- Attribute assignment
- Department-based group assignment
- Account disabling
- Session revocation
- Group membership removal

## Prerequisites

- Microsoft Entra ID
- Microsoft Graph PowerShell
- Appropriate Microsoft Graph permissions
- IAM security groups

## Joiner Automation

### Step 1 — Connect to Microsoft Graph

![Graph Connection](../screenshots/powershell-automation/01-graph-connection.png)

### Step 2 — Create User

The create-user.ps1 script accepts reusable parameters for
first name, last name, department, and job title.

![Create User_Script](../screenshots/powershell-automation/02-create-user-script.png)

### Step 3 — Execute Provisioning

![User Created](../screenshots/powershell-automation/03-user-created.png)

### Step 4 — Verify User Attributes

![User Attributes](../screenshots/powershell-automation/04-user-attributes.png)

### Step 5 — Verify Group Assignment

![Finance Group](../screenshots/powershell-automation/05-finance-group-membership.png)

## Leaver Automation

### Step 1 — Disable User

The disable-user.ps1 script disables the account, revokes
active sessions, and removes the user from IAM department
security groups.

![Disable User](../screenshots/powershell-automation/06-disable-user-script.png)

### Step 2 — Verify User Before Deprovisioning

![User Before_Disable](../screenshots/powershell-automation/07-user-before-disable.png)

### Step 3 — Execute Leaver Automation

![Leaver Automation](../screenshots/powershell-automation/08-leaver-automation.png)

### Step 4 — Verify Account Disabled

![User Disabled](../screenshots/powershell-automation/09-user-disabled.png)

### Step 5 — Verify Access Removal

![Group Membership](../screenshots/powershell-automation/10-group-membership-removed.png)


## Results

The automation successfully demonstrates:

- Automated identity provisioning
- Attribute assignment
- Group-based access assignment
- Account deactivation
- Session revocation
- Group-based access removal

## IAM Lifecycle

Joiner:

New Employee → Create Account → Assign Attributes → Assign Group → Access

Leaver:

Employee Departure → Disable Account → Revoke Sessions → Remove Groups → Access Removed
