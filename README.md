# Enterprise IAM Lab

A hands-on Identity and Access Management (IAM) lab demonstrating enterprise identity lifecycle management, access control, authentication security, and automation using Microsoft Entra ID.

This project was built to simulate common IAM operations performed in an enterprise environment, including user provisioning, role-based access control, application access, MFA enforcement, Conditional Access, and automated identity lifecycle management.

---

## Project Overview

The Enterprise IAM Lab demonstrates how identity and access controls can be designed, implemented, tested, and documented in a Microsoft Entra ID environment.

The lab focuses on the following IAM capabilities:

* Joiner–Mover–Leaver (JML) processes
* User and group management
* Role-Based Access Control (RBAC)
* Application access management
* Multi-Factor Authentication (MFA)
* Microsoft Entra Conditional Access
* Group-based access control
* SAML application authentication
* Microsoft Graph PowerShell automation
* Identity provisioning and deprovisioning

---

## Architecture

The lab uses Microsoft Entra ID as the centralized identity provider.

```text
                         Microsoft Entra ID
                                |
              +-----------------+-----------------+
              |                 |                 |
             Users            Groups          Enterprise Apps
              |                 |                 |
              |          +------+-------+         |
              |          |              |         |
              |       RBAC Groups   Department    |
              |                      Groups       |
              |                                   |
              +------------------+-------------------+
                                 |
                         Conditional Access
                                 |
                         MFA / Access Policies
                                 |
                         SAML Application
```

---

# IAM Scenarios

## 1. Identity Lifecycle Management

The lab demonstrates the Joiner–Mover–Leaver identity lifecycle.

### Joiner

A new employee is provisioned into Microsoft Entra ID with the appropriate identity attributes and department security group.

```text
New Employee
     ↓
User Provisioning
     ↓
Entra ID Account
     ↓
Department / Job Title
     ↓
Security Group Assignment
     ↓
Application Access
```

### Mover

Changes to an employee's department or role can be used to demonstrate how group membership and access should change as responsibilities change.

```text
Role / Department Change
          ↓
Identity Attributes Updated
          ↓
Group Membership Updated
          ↓
Access Adjusted
```

### Leaver

When an employee leaves the organization, their account is disabled and access is removed.

```text
Employee Departure
        ↓
Disable Account
        ↓
Revoke Sessions
        ↓
Remove Group Membership
        ↓
Access Removed
```

Documentation:

* [Identity Lifecycle Management](documentation/joiner-mover-leaver.md)

---

# 2. Role-Based Access Control

The lab demonstrates RBAC using Microsoft Entra roles and security groups.

Example users include:

| User          | Department | Role                  |
| ------------- | ---------- | --------------------- |
| Jane Smith    | Finance    | Financial Analyst     |
| John Smith    | IT         | Systems Administrator |
| Lisa Brown    | Marketing  | Marketing Specialist  |
| Mike Davis    | Sales      | Sales Representative  |
| Sarah Johnson | HR         | HR Specialist         |

Department security groups include:

* `SG-IT-Users`
* `SG-HR-Users`
* `SG-Finance-Users`
* `SG-Sales-Users`
* `SG-Marketing-Users`

The lab also demonstrates administrative role assignment and separation of privileges.

Documentation:

* [RBAC Documentation](documentation/rbac.md)

---

# 3. Application Access Management

The lab demonstrates group-based application access using Microsoft Entra enterprise applications.

For example:

```text
SG-Finance-Users
       ↓
Enterprise Application
       ↓
Finance Users
       ↓
Application Access
```

Users who are members of the appropriate security group are granted access to the application.

Users who are not assigned to the application are prevented from accessing it.

This demonstrates the IAM principle of:

> **Access should be granted based on business role and authorization rather than individual assignment whenever possible.**

---

# 4. SAML Authentication

The Microsoft Entra SAML Toolkit is used to demonstrate federated application authentication.

The lab demonstrates:

* SAML-based authentication
* Enterprise application configuration
* User and group assignment
* Application access control
* Authentication enforcement through Conditional Access

---

# 5. Multi-Factor Authentication

The lab demonstrates MFA enforcement using Microsoft Entra Conditional Access.

Example scenario:

```text
User
 ↓
Finance Security Group
 ↓
SAML Application
 ↓
Conditional Access
 ↓
MFA Required
 ↓
Application Access
```

A Finance user assigned to the application is required to complete MFA before accessing the application.

Documentation:

* [Conditional Access](documentation/conditional-access.md)

---

# 6. Conditional Access

The lab demonstrates Conditional Access policies used to control access based on identity, group membership, application, and authentication requirements.

Example policy scenarios include:

### Finance MFA

```text
User
+
Finance Group
+
SAML Application
        ↓
Require MFA
```

### Access Restriction

A separate Conditional Access scenario demonstrates restricting access based on defined conditions.

The lab also uses **Report-only** mode when testing policies before enforcement.

This demonstrates an important enterprise security practice:

> Test Conditional Access policies in Report-only mode before enabling enforcement.

Documentation:

* [Conditional Access Documentation](documentation/conditional-access.md)

---

# 7. PowerShell Automation

Microsoft Graph PowerShell is used to automate identity lifecycle operations.

The automation demonstrates:

### User Provisioning

`create-user.ps1`

The script can:

* Create a new Entra ID user
* Set the user's first and last name
* Set department
* Set job title
* Set usage location
* Generate the user's UPN
* Assign the user to the appropriate department security group

Example:

```powershell
.\scripts\create-user.ps1 `
    -FirstName "Alex" `
    -LastName "Johnson" `
    -Department "Finance" `
    -JobTitle "Financial Analyst"
```

### User Deprovisioning

`disable-user.ps1`

The script can:

* Locate the user
* Disable the account
* Revoke active sessions
* Remove department security group membership
* Verify the account's final state

Example:

```powershell
.\scripts\disable-user.ps1 `
    -UserPrincipalName "alex.johnson@yourtenant.onmicrosoft.com"
```

Documentation:

* [PowerShell Automation](documentation/powershell-automation.md)

---

# Technologies

| Technology              | Purpose                           |
| ----------------------- | --------------------------------- |
| Microsoft Entra ID      | Identity and access management    |
| Microsoft Graph         | Identity automation               |
| PowerShell              | IAM automation                    |
| Conditional Access      | Access policy enforcement         |
| MFA                     | Strong authentication             |
| Security Groups         | Group-based access control        |
| Enterprise Applications | Application access management     |
| SAML                    | Federated authentication          |
| GitHub                  | Documentation and version control |
---

# IAM Skills Demonstrated

This project demonstrates practical experience with:

### Identity Administration

* User creation
* User modification
* User disabling
* Group management
* User lifecycle management
* Identity attributes

### Access Management

* RBAC
* Group-based access
* Application assignment
* Least privilege
* Access removal

### Authentication

* MFA
* Conditional Access
* SAML authentication
* Authentication enforcement

### Automation

* Microsoft Graph PowerShell
* Automated provisioning
* Automated deprovisioning
* Identity lifecycle automation

### Troubleshooting

The lab also documents troubleshooting performed during implementation, including application assignment, authentication, Conditional Access, MFA, and access-control issues.

---

# Security Principles Demonstrated

The lab applies several core IAM security principles:

* **Least Privilege**
* **Role-Based Access Control**
* **Group-Based Access Management**
* **Defense in Depth**
* **Strong Authentication**
* **Identity Lifecycle Management**
* **Access Revocation**
* **Separation of Duties**
* **Automated Provisioning and Deprovisioning**

---

# Project Goals

The goal of this project is to demonstrate practical IAM knowledge through hands-on implementation rather than relying solely on certification or theoretical knowledge.

The lab is designed to simulate common enterprise IAM responsibilities such as:

* Provisioning users
* Managing access
* Troubleshooting authentication issues
* Implementing MFA
* Configuring Conditional Access
* Managing application access
* Supporting RBAC
* Automating identity lifecycle processes

---

# Future Enhancements

Planned improvements include:

* Automated Joiner–Mover–Leaver workflows
* Additional Microsoft Graph automation
* Access review scenarios
* Privileged Identity Management (PIM)
* Dynamic group membership
* Additional Conditional Access scenarios
* Automated reporting
* Improved error handling and logging
* Integration with ITSM workflows

---

# Disclaimer

This project is a personal lab environment created for educational and portfolio purposes.

All users, groups, applications, and organizational scenarios are fictional and are not representative of production identities or systems.

No production credentials, secrets, or sensitive organizational information are stored in this repository.

---

## Author

**Renese Ames**

Enterprise IAM Lab focused on Microsoft Entra ID, identity lifecycle management, access control, authentication security, and IAM automation.
