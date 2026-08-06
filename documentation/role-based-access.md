# Role-Based Access Control (RBAC)

## Overview

This lab demonstrates **Role-Based Access Control (RBAC)** in Microsoft Entra ID by assigning an administrative role to an authorized user and validating that only users with the appropriate role can perform privileged administrative tasks.

RBAC is a core Identity and Access Management (IAM) security principle that grants permissions based on a user's job responsibilities rather than assigning permissions directly to individual accounts.

---

## Objective

Demonstrate that:

* Authorized administrators can perform privileged operations.
* Standard users cannot perform administrative actions.
* Administrative permissions are enforced through Microsoft Entra ID roles.
* Least Privilege is maintained by limiting elevated permissions to authorized personnel.

---

## Lab Environment

| User       | Department | Assigned Role          |
| ---------- | ---------- | ---------------------- |
| John Smith | IT         | Helpdesk Administrator |
| Jane Smith | Finance    | Standard User          |

---

## Scenario

### Step 1 – Assign Administrative Role

The **Helpdesk Administrator** role was assigned to **John Smith** using Microsoft Entra ID.

**Screenshot**

```
screenshots/role-based-access/01-helpdesk-role-assigned.png
```

---

### Step 2 – Validate Authorized Access

Signed into Microsoft Entra ID as **John Smith**.

As a Helpdesk Administrator, John successfully reset another user's password.

**Result**

✅ Password reset completed successfully.

**Screenshot**

```
screenshots/role-based-access/02-password-reset-success.png
```

---

### Step 3 – Validate Unauthorized Access

Signed into Microsoft Entra ID as **Jane Smith**.

Jane attempted to reset another user's password.

Because Jane is a standard user and does not have the Helpdesk Administrator role, Microsoft Entra ID prevented the operation.

**Result**

❌ Access denied.

**Screenshot**

```
screenshots/role-based-access/03-access-denied.png
```

---

# RBAC Flow

```text
             Helpdesk Administrator
                      │
                      ▼
               John Smith (IT)
                      │
                      ▼
          Reset User Password
                      │
                      ▼
                  Success ✅



              Standard User
                    │
                    ▼
          Jane Smith (Finance)
                    │
                    ▼
         Reset User Password
                    │
                    ▼
             Access Denied ❌
```

---

## Security Principles Demonstrated

* Role-Based Access Control (RBAC)
* Principle of Least Privilege
* Administrative Role Assignment
* Privileged Access Management
* Separation of Duties
* Identity Governance

---

## Key Takeaways

This exercise demonstrates how Microsoft Entra ID uses administrative roles to secure privileged operations.

Only users assigned the appropriate role can perform administrative tasks such as password resets, while standard users are restricted from accessing privileged functionality. This approach reduces the organization's attack surface and helps enforce the Principle of Least Privilege.

---

## Skills Demonstrated

* Microsoft Entra ID
* Identity and Access Management (IAM)
* Role-Based Access Control (RBAC)
* Administrative Role Assignment
* User Administration
* Password Management
* Security Best Practices
* Access Control Validation

