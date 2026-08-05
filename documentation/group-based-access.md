# Group-Based Access Management

## Objective

The objective of this lab was to implement group-based access management
using Microsoft Entra ID. Instead of assigning access permissions directly
to individual users, security groups were created based on department
and job function.

## Scenario

A fictional organization has Finance, IT, HR, Sales, and Marketing departments. Users are placed
into department-specific security groups to simplify access management
and support consistent access assignments.

## Groups Created

- SG-Finance-Users
- SG-IT-Users
- SG-HR-Users
- SG-Sales-Users
- SG-Marketing-Users

## User Assignments

| User | Department | Group |
|---|---|---|
| Jane Smith | Finance | GG-Finance-Users |
| John Smith | IT | SG-IT-Users |
| Sarah Johnson | HR | SG-HR-Users |
| Lisa Brown | Marketing | SG-Marketing-Users |
| Mike Davis | Sales | SG-Sales-Users |

## Group Membership

Example: 
Created a Security Group "SG-Finance-User" and added Jane to the appropriate group.
(../screenshots/group-based-membership/01-finance-group-membership.png)

## Implementation

1. Created security groups in Microsoft Entra ID.
2. Configured group membership as Assigned.
3. Added users to their appropriate department groups.
4. Verified group membership.
5. Documented the group structure and access model.

## IAM Concept Demonstrated

This lab demonstrates group-based access management, which allows
organizations to manage user access through centralized group membership
rather than assigning permissions individually to each user.

## Security and Operational Benefits

Group-based access management can help:

- Standardize access based on job function or department.
- Reduce manual permission assignments.
- Simplify onboarding and offboarding.
- Improve consistency in access management.
- Support least-privilege access models.
