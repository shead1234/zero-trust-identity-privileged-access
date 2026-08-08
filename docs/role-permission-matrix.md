# Role and Permission Matrix

## Project

**Zero Trust Identity and Privileged Access**

## Organization

**Northstar Retail Group**

## Purpose

This matrix defines the planned Microsoft Entra and Azure permissions for each fictional identity and security group.

Access will follow these principles:

- Assign permissions through groups where practical
- Use the lowest sufficient role
- Use the narrowest practical scope
- Separate everyday and administrative access
- Avoid permanent privileged access
- Document every privileged assignment

## Azure Role Assignments

| Security Group | Azure Role | Planned Scope | Access Purpose |
|---|---|---|---|
| SG-NRG-Azure-Readers | Reader | Project resource group | View Azure resources without modifying them |
| SG-NRG-Azure-Contributors | Contributor | Project resource group | Manage project resources without managing access |
| SG-NRG-Security-Readers | Security Reader | Subscription or project scope | Review security recommendations and security status |
| SG-NRG-Guest-Auditors | Reader | Project resource group | Provide limited read-only audit visibility |
| SG-NRG-Privileged-Role-Eligible | Custom role or selected administrative role | Project resource group | Perform approved, time-limited administrative tasks |

## Identity Access Matrix

| Identity | Primary Groups | Planned Access | Prohibited Access |
|---|---|---|---|
| Alex Morgan | SG-NRG-All-Employees, SG-NRG-IT-Operations | Standard employee and IT operations access | No privileged Azure administration |
| Alex Morgan Admin | SG-NRG-Privileged-Role-Eligible, SG-NRG-CA-Admin-Protection | Eligible administrative access | No everyday email or routine browsing |
| Maya Chen | SG-NRG-All-Employees, SG-NRG-Security-Readers, SG-NRG-Azure-Readers | Read-only Azure and security visibility | Cannot modify resources or role assignments |
| Daniel Brooks | SG-NRG-All-Employees, SG-NRG-Finance-Users | Finance-related application access | No Azure administration |
| Priya Shah | SG-NRG-All-Employees, SG-NRG-HR-Users | Human-resources application access | No Azure administration |
| Jordan Lee | SG-NRG-Contractors | Temporary application-support access | No tenant-wide or privileged access |
| Taylor Reed | SG-NRG-Guest-Auditors, SG-NRG-Azure-Readers | Read-only project audit access | Cannot modify resources |
| Break Glass Admin 01 | SG-NRG-CA-Exclusions | Emergency tenant recovery | No routine use |
| Break Glass Admin 02 | SG-NRG-CA-Exclusions | Emergency tenant recovery | No routine use |

## Administrative Role Strategy

Administrative access will be divided into three categories.

### Permanent Access

Permanent privileged access will be minimized.

Emergency-access accounts may require permanent emergency privileges to ensure tenant recovery, but their use will be monitored and restricted.

### Eligible Access

Where Microsoft Entra Privileged Identity Management is available, administrator accounts will receive eligible assignments.

Activation controls may include:

- Multifactor authentication
- Business justification
- Limited activation duration
- Approval for sensitive roles
- Notification of activation
- Audit-log recording

### Active Access

Active privileged access will only exist during an approved administrative task.

After the activation period ends, the account will return to its nonprivileged state.

## Built-In Role Selection

### Reader

Reader permits users to view Azure resources but not modify them.

Planned use:

- Security analysts requiring resource visibility
- External auditors
- General read-only validation

### Contributor

Contributor permits resource management but does not permit users to assign Azure roles.

Planned use:

- Approved project administrators
- Temporary resource-management activities

Contributor will not be assigned when Reader access is sufficient.

### Security Reader

Security Reader provides read-only visibility into security-related information.

Planned use:

- Security operations personnel
- Security posture reviews
- Investigation and validation activities

### User Access Administrator

User Access Administrator can manage Azure role assignments.

This role is highly privileged and will not be granted to standard users or general contributors.

### Owner

Owner can manage resources and access assignments.

Owner assignments will be minimized because the role provides broad control over Azure resources and authorization.

## Planned Custom Role

A custom Azure role will be created to demonstrate least-privilege authorization.

Proposed role name:

**NRG Project Resource Operator**

The role is intended to permit selected operational actions within the project resource group without permitting:

- Role-assignment changes
- Policy-assignment changes
- Subscription-level administration
- Resource-group deletion
- Privilege escalation

The final allowed actions will be selected after the project resource and validation requirements are confirmed.

## Scope Strategy

Azure role assignments will use the narrowest practical scope.

Preferred order:

1. Individual resource
2. Resource group
3. Subscription
4. Management group

The project will primarily use resource-group scope to prevent unnecessary subscription-wide access.

## Direct Assignment Exceptions

Direct role assignments to individual users will generally be avoided.

A direct assignment may be used only when:

- The access is temporary
- A group assignment is not technically supported
- Emergency access requires it
- The exception is documented
- The assignment is removed after validation

## Separation of Duties

The design separates these responsibilities:

| Responsibility | Planned Identity |
|---|---|
| Everyday employee work | Standard user account |
| Azure administration | Separate administrator account |
| Security visibility | Security reader |
| Resource modification | Contributor or custom operator |
| Access assignment management | Highly restricted administrator |
| Emergency tenant recovery | Break-glass account |
| External audit review | Guest auditor |

## Validation Tests

The following authorization tests are planned:

1. Confirm a Reader can view project resources.
2. Confirm a Reader cannot create, modify, or delete resources.
3. Confirm a Contributor can manage permitted resources.
4. Confirm a Contributor cannot create Azure role assignments.
5. Confirm a standard employee has no administrative access.
6. Confirm the guest auditor has read-only access.
7. Confirm the custom role allows approved operations.
8. Confirm the custom role blocks prohibited operations.
9. Confirm privileged access expires when the activation period ends.
10. Confirm role-assignment changes appear in Azure and Microsoft Entra logs.

## Evidence Requirements

Evidence will include:

- Group membership exports
- Azure role-assignment exports
- Custom-role definition
- Successful authorized actions
- Failed unauthorized actions
- Privileged-role activation records
- Audit-log entries
- Redacted screenshots

No tenant IDs, subscription IDs, passwords, or sensitive identity information will be committed to GitHub.