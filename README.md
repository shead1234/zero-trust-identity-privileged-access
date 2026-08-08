# Zero Trust Identity & Privileged Access

An employer-focused Microsoft Entra ID and Azure security project demonstrating Zero Trust identity controls, privileged-access management, Identity Governance, Conditional Access, and least-privilege Azure RBAC.

**Organization:** Northstar Retail Group *(fictional)*  
**Environment:** Development / Portfolio Lab  
**Platform:** Microsoft Entra ID P2 + Microsoft Azure  
**Status:** Validated

---

## Project Goals

- Separate standard and privileged identities
- Enforce multifactor authentication
- Block legacy authentication
- Implement just-in-time privileged access
- Review and remediate unnecessary access
- Apply least-privilege Azure RBAC
- Validate allowed and denied operations
- Maintain auditable security activity

---

## Architecture

The project uses Microsoft Entra ID as the identity control plane and Azure RBAC for resource authorization.

Key components:

- Role-based Entra security groups
- Dedicated administrative identities
- Emergency-access accounts
- Conditional Access
- Privileged Identity Management (PIM)
- Identity Governance access reviews
- Azure built-in RBAC roles
- Custom least-privilege Azure role
- Microsoft Entra audit/sign-in logs
- Azure Activity Log

Detailed design documentation is available in [`docs/architecture.md`](docs/architecture.md).

---

## Security Controls Implemented

| Control | Implementation |
|---|---|
| MFA | Conditional Access enforcement |
| Legacy Authentication | Block policy |
| Privileged Access | PIM eligible assignments |
| JIT Administration | MFA + approval + justification + 1-hour activation |
| Emergency Access | Two dedicated break-glass administrators |
| Access Certification | Identity Governance access reviews |
| Azure Read Access | Group-based Reader RBAC |
| Resource Administration | Least-privilege custom role |
| Auditability | Entra audit logs + Azure Activity Log |

---

## Validation Highlights

### Conditional Access
- MFA tested in Report-only before enforcement
- Live MFA enforcement successfully validated
- Legacy-authentication blocking validated before enforcement
- Break-glass identities excluded from restrictive policies

### Privileged Identity Management
Validated the complete privileged-access lifecycle:

`Eligible → Request → Approval → Activated → Privileged Action → Deactivated`

### Identity Governance
Access reviews successfully:
- Approved legitimate privileged access
- Denied inappropriate contractor access
- Removed denied access after remediation

### Azure RBAC
Live positive and negative authorization tests confirmed:

- Reader can view resources but cannot modify them
- Contributor can modify resources but cannot assign RBAC roles
- Custom NSG operator can manage security rules but cannot delete the NSG

---

## Custom Azure Role

Created:

`NRG NSG Security Rule Operator`

The role allows IT Operations to manage NSG security rules while preventing broader infrastructure or RBAC administration.

This demonstrates custom-role design and least-privilege authorization.

---

## Repository Structure

```text
zero-trust-identity-privileged-access/
├── docs/
│   ├── architecture.md
│   ├── decision-log.md
│   ├── identity-design.md
│   ├── project-charter.md
│   ├── role-permission-matrix.md
│   ├── screenshot-log.md
│   └── validation-report.md
├── evidence/
│   ├── exports/
│   └── screenshots/
├── policies/
├── roles/
├── scripts/
├── .gitignore
└── README.md