# Identity Design

## Organization

**Northstar Retail Group**

This project uses fictional identities representing common employee, contractor, guest, and administrative access scenarios.

## Identity Principles

The identity environment will follow these principles:

- Verify users explicitly
- Grant the minimum required access
- Assign permissions through groups where practical
- Separate standard and administrative accounts
- Avoid permanent privileged access
- Review access regularly
- Remove access when it is no longer required

## User Naming Standard

### Standard Users

User principal names will use:

`firstname.lastname@<tenant-domain>`

Example:

`alex.morgan@<tenant-domain>`

### Administrator Accounts

Administrative accounts will use:

`adm-firstname.lastname@<tenant-domain>`

Example:

`adm-alex.morgan@<tenant-domain>`

Administrators will use their standard account for email and everyday work. The separate administrator account will only be used for privileged tasks.

### Contractor Accounts

Contractor accounts will use:

`ctr-firstname.lastname@<tenant-domain>`

Example:

`ctr-jordan.lee@<tenant-domain>`

### Emergency-Access Accounts

Emergency-access accounts will use:

`bg-admin01@<tenant-domain>`

`bg` represents **break glass**.

These accounts will not be used for routine administrative work.

## Fictional Identity Inventory

| Display Name | Account Type | Department or Purpose | Planned Access |
|---|---|---|---|
| Alex Morgan | Standard employee | IT Operations | General employee access |
| Alex Morgan Admin | Administrator | Azure administration | Eligible privileged access |
| Maya Chen | Standard employee | Security Operations | Security-reader access |
| Daniel Brooks | Standard employee | Finance | Finance application access |
| Priya Shah | Standard employee | Human Resources | HR application access |
| Jordan Lee | Contractor | Application support | Temporary application access |
| Taylor Reed | Guest | External auditor | Read-only audit access |
| Break Glass Admin 01 | Emergency administrator | Tenant recovery | Emergency-only access |
| Break Glass Admin 02 | Emergency administrator | Tenant recovery | Emergency-only access |

All identities are fictional and do not represent real employees.

## Security Group Design

| Group Name | Group Type | Purpose |
|---|---|---|
| SG-NRG-All-Employees | Assigned security group | Standard employee access |
| SG-NRG-IT-Operations | Assigned security group | IT operations access |
| SG-NRG-Security-Readers | Assigned security group | Read-only security visibility |
| SG-NRG-Finance-Users | Assigned security group | Finance application access |
| SG-NRG-HR-Users | Assigned security group | HR application access |
| SG-NRG-Contractors | Assigned security group | Contractor access |
| SG-NRG-Guest-Auditors | Assigned security group | External auditor access |
| SG-NRG-Azure-Readers | Assigned security group | Azure Reader assignments |
| SG-NRG-Azure-Contributors | Assigned security group | Controlled resource management |
| SG-NRG-Privileged-Role-Eligible | Assigned security group | Eligible privileged access |
| SG-NRG-CA-MFA-Users | Assigned security group | Conditional Access MFA testing |
| SG-NRG-CA-LegacyAuth-Block | Assigned security group | Legacy authentication blocking |
| SG-NRG-CA-Admin-Protection | Assigned security group | Strong administrator protections |
| SG-NRG-CA-Exclusions | Assigned security group | Approved policy exclusions |

## Group Naming Standard

Security groups will use:

`SG-NRG-<Purpose>`

Where:

- `SG` means security group
- `NRG` means Northstar Retail Group
- `<Purpose>` describes the group’s business or security function

Permissions will not be included directly in a user’s name.

## Planned Group Membership

| Identity | Group Membership |
|---|---|
| Alex Morgan | SG-NRG-All-Employees, SG-NRG-IT-Operations |
| Alex Morgan Admin | SG-NRG-Privileged-Role-Eligible, SG-NRG-CA-Admin-Protection |
| Maya Chen | SG-NRG-All-Employees, SG-NRG-Security-Readers, SG-NRG-Azure-Readers |
| Daniel Brooks | SG-NRG-All-Employees, SG-NRG-Finance-Users |
| Priya Shah | SG-NRG-All-Employees, SG-NRG-HR-Users |
| Jordan Lee | SG-NRG-Contractors |
| Taylor Reed | SG-NRG-Guest-Auditors, SG-NRG-Azure-Readers |
| Break Glass Admin 01 | SG-NRG-CA-Exclusions |
| Break Glass Admin 02 | SG-NRG-CA-Exclusions |

## Administrative Separation

Administrative users will have two accounts:

1. A standard account for normal work
2. A separate administrator account for privileged tasks

Administrative accounts will not be used for:

- Email
- General web browsing
- Routine collaboration
- Nonadministrative applications
- Everyday employee tasks

## Privileged-Access Design

Where licensing and tenant capabilities permit:

- Privileged roles will be eligible instead of permanently active
- Activation will require justification
- Activation will have a limited duration
- Sensitive roles may require approval
- Privileged activity will be reviewed through audit logs
- Permanent Global Administrator assignments will be minimized

## Emergency-Access Design

Two emergency-access accounts are planned to reduce tenant lockout risk.

The accounts will:

- Be cloud-only identities
- Use long, independently stored credentials
- Be excluded from applicable Conditional Access policies
- Have no mailbox or routine application use
- Be monitored for every sign-in
- Be tested periodically
- Be used only during an emergency

Emergency-access credentials and recovery details will not be stored in this GitHub repository.

## Guest and Contractor Controls

Guest and contractor access will:

- Have a documented business owner
- Use the minimum required permissions
- Have an expected expiration or review date
- Be included in periodic access reviews
- Be removed when the engagement ends
- Avoid privileged roles unless explicitly approved

## Identity Lifecycle

### Joiner

- Create the identity
- Assign the correct department groups
- Require registration of approved authentication methods
- Confirm the account owner and manager
- Validate required access

### Mover

- Review existing group membership
- Remove access from the previous role
- Add access required for the new role
- Review privileged assignments
- Record the change

### Leaver

- Block sign-in
- Revoke active sessions
- Remove group membership
- Remove Azure and Microsoft Entra role assignments
- Transfer required business data
- Remove or delete the identity according to policy

## Validation Goals

The implementation will validate that:

- Standard users cannot perform privileged actions
- Administrators must use separate privileged identities
- Group-based assignments provide the expected access
- Contractors and guests receive limited access
- Privileged access is time-limited where supported
- Emergency-access accounts remain available for recovery
- Identity changes appear in audit logs