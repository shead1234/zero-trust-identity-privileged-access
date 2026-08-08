# Project Charter

## Project Name

**Zero Trust Identity and Privileged Access**

## Organization

**Northstar Retail Group**

Northstar Retail Group is a fictional retail organization modernizing its identity and access-management environment using Microsoft Entra ID and Azure.

## Business Problem

Northstar Retail Group currently relies on permanent administrative access, inconsistent account-management procedures, and limited controls for employees, contractors, guests, and privileged users.

These conditions increase the risk of:

* Excessive permissions
* Compromised administrator accounts
* Unauthorized access to Azure resources
* Stale employee and guest accounts
* Weak authentication practices
* Limited visibility into privileged activity
* Inconsistent joiner, mover, and leaver processes

The organization needs a Zero Trust identity architecture that verifies users explicitly, applies least-privilege access, and continuously reviews access.

## Project Objective

Design, implement, test, and document a secure Microsoft Entra identity and privileged-access environment.

The project will demonstrate how Northstar Retail Group can protect cloud resources using:

* Role-based access control
* Multifactor authentication
* Conditional Access
* Privileged Identity Management
* Access reviews
* Guest-user governance
* Identity monitoring and auditing
* Documented identity lifecycle procedures

## Project Scope

### Identity Organization

* Create representative employee, contractor, guest, and administrator identities
* Create security groups based on job responsibilities
* Separate standard user accounts from administrator accounts
* Document naming standards and account ownership

### Least-Privilege Access

* Assign Azure permissions through groups where practical
* Use built-in Azure roles appropriately
* Create a custom Azure role when a built-in role grants excessive permissions
* Validate authorized and unauthorized actions
* Identify and remove unnecessary access

### Conditional Access

* Require multifactor authentication for selected users and applications
* Apply stronger protections to administrative accounts
* Block legacy authentication
* Design an emergency-access account exclusion
* Use report-only mode before policy enforcement
* Review sign-in results before enabling policies

### Privileged Access

* Configure eligible rather than permanent privileged assignments where supported
* Require justification for privileged-role activation
* Limit activation duration
* Require approval for selected sensitive roles where appropriate
* Test privileged-role activation and expiration

### Identity Governance

* Create an access-review process for privileged groups and guest users
* Identify stale or unnecessary access
* Document joiner, mover, and leaver procedures
* Document periodic access-certification responsibilities

### Monitoring and Validation

* Review Microsoft Entra sign-in logs
* Review audit logs
* Validate Conditional Access results
* Capture privileged-role activity
* Test unauthorized access attempts
* Record all validation evidence

## Out of Scope

The following items are outside the primary scope of this portfolio project:

* Production user identities
* Production application migration
* Full human-resources system integration
* Identity synchronization from an on-premises Active Directory environment
* Passwordless hardware deployment to physical employees
* Enterprise-wide licensing procurement
* Permanent production policy enforcement
* Security controls unrelated to identity and access management

## Planned Deliverables

* Project charter
* Identity and group architecture
* Identity naming standard
* Role and permission matrix
* Custom Azure role definition
* Conditional Access policy documentation
* Privileged Identity Management configuration
* Emergency-access account design
* Access-review process
* Joiner, mover, and leaver procedure
* Validation report
* Sign-in and audit-log evidence
* Screenshots and configuration exports
* Final GitHub repository documentation

## Success Criteria

The project will be considered successful when:

1. Users and administrators are separated into clearly defined identities and groups.
2. Azure access follows least-privilege principles.
3. Unauthorized users cannot perform protected administrative actions.
4. Authorized users can complete their required tasks.
5. Administrative access is eligible and time-limited where supported.
6. Conditional Access policies are tested safely before enforcement.
7. Legacy authentication is blocked or documented for blocking.
8. Emergency access is designed and protected appropriately.
9. Guest and privileged access can be periodically reviewed.
10. Sign-in, audit, and privileged-access activity can be investigated.
11. Validation evidence is documented without exposing sensitive information.
12. The completed project is published as an employer-ready GitHub case study.

## Constraints and Assumptions

* The project will use a personal Microsoft Azure and Microsoft Entra tenant.
* Some features may require Microsoft Entra ID P1, P2, Governance, or trial licensing.
* Features unavailable under the active license will be documented and simulated where necessary.
* Test identities will not represent real employees.
* No passwords, secrets, tenant identifiers, subscription identifiers, or sensitive account information will be committed to GitHub.
* Policies will be tested carefully to prevent account lockout.
* The emergency-access design will be completed before enforcing high-impact Conditional Access policies.

## Risk Controls

To reduce the risk of accidental tenant lockout or excessive cost:

* Conditional Access policies will begin in report-only mode.
* Emergency-access accounts will be excluded from applicable policies.
* Administrative sessions will be kept available while policies are tested.
* Access changes will be validated before permanent enforcement.
* Azure resources will use low-cost configurations where possible.
* Temporary identities, groups, assignments, and resources will be removed during final cleanup.

## Project Workflow

The project will follow this sequence:

**Plan → Design → Build → Test → Capture Evidence → Document → Publish → Validate → Clean Up**

## Final Outcome

The completed project will demonstrate practical experience with Microsoft Entra ID, Azure RBAC, Conditional Access, privileged identity security, access governance, Zero Trust principles, identity monitoring, technical documentation, and controlled security validation.
