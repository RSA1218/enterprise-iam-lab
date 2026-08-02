# Identity Lifecycle Management

## Overview

This lab demonstrates basic identity lifecycle management using Microsoft Entra ID.

Microsoft Entra ID is used as the centralized identity provider for the lab environment. 
Test user identities are created to represent employees within different organizational 
departments and job functions.

The lab demonstrates the following IAM lifecycle activities:

- User provisioning
- User attribute management
- Group-based access management
- Role-based access control
- Access modification
- User deprovisioning

## User Provisioning

Users were created in Microsoft Entra ID to represent fictional employees.

### Example User

| Attribute | Value |
|---|---|
| Name | Jane Smith |
| Username | jane.smith@yourtenant.onmicrosoft.com |
| Department | Finance |
| Job Title | Financial Analyst |

### Provisioning Process

1. Navigate to **Microsoft Entra ID**.
2. Select **Identity**.
3. Navigate to **Users → All users**.
4. Select **New user**.
5. Create a fictional employee account.
6. Configure the user's identity information.
7. Configure organizational attributes such as department and job title.
8. Verify that the user account was successfully created.

## IAM Concepts Demonstrated

### Provisioning

User provisioning is the process of creating and configuring an identity so that a user can access organizational resources.

### Identity Attributes

User attributes such as department and job title provide information that can be used to support access management and governance decisions.

### Group-Based Access

Users can be assigned to groups based on organizational attributes such as department or job function. Groups can then be used to manage access to applications and resources.

### Role-Based Access Control

Access can be assigned according to a user's job responsibilities and required level of access.

### Deprovisioning

When a user leaves the organization, access should be removed or disabled as part of the identity lifecycle process.

## Evidence

Screenshots are included in the `screenshots` directory to demonstrate the user provisioning process.

> Note: All users in this lab are fictional test accounts. Sensitive tenant information and credentials have been removed or redacted.
