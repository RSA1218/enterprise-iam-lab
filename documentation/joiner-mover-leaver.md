# Joiner–Mover–Leaver (JML) Identity Lifecycle Management

## Objective

Demonstrate the Joiner–Mover–Leaver (JML) identity lifecycle using Microsoft Entra ID.

The JML lifecycle manages a user's identity and access throughout their employment:

```text
JOINER
New Employee
     ↓
Account Provisioning
     ↓
Group & Application Access
     ↓
MFA / Conditional Access


MOVER
Role or Department Change
     ↓
Access Review
     ↓
Remove Previous Access
     ↓
Grant New Access


LEAVER
Employee Departure
     ↓
Disable Account
     ↓
Remove Access
     ↓
Revoke Authentication
```

Microsoft Entra identifies these three lifecycle phases as Joiner, Mover, and Leaver. Lifecycle Workflows can automate tasks associated with each phase.

---

# 1. Joiner — New Employee

## Scenario

A new employee, **Dorothy Clark**, joins the organization as a Financial Analyst.

Jane's initial attributes are:

| Attribute      | Value                        |
| -------------- | ---------------------------- |
| Name           | Dorothy Clark                   |
| Department     | Finance                      |
| Job Title      | Financial Advisor            |
| Security Group | `SG-Finance-Users`           |
| Application    | Microsoft Entra SAML Toolkit |
| Authentication | MFA                          |

The objective is to provision Jane with the access required for her Finance role.

---

## 1.1 Create the User

Navigate to:

**Microsoft Entra ID → Users → New user**

Create:

`Dorothy Clark`

Configure the appropriate user attributes, including:

* First Name
* Last Name
* Department
* Job Title

Capture a screenshot of the completed user profile.

**Screenshot:**

![Create User](../screenshots/joiner-mover-leaver/01-joiner-user-created.png.png)

---

