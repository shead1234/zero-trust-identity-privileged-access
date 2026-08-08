# Project 2 Validation Report

## Zero Trust Identity & Privileged Access

**Organization:** Northstar Retail Group  
**Platform:** Microsoft Entra ID P2 + Microsoft Azure  
**Environment:** Development / Portfolio Lab  
**Status:** Validated

---

## Identity Architecture

Created a role-based identity model using dedicated security groups and fictional cloud identities.

Validated:
- Standard and privileged identities separated
- Department and access groups configured
- Two emergency Global Administrator accounts created
- Break-glass identities excluded from Conditional Access
- Entra ID P2 licensing enabled for required test identities

**Result:** PASS

---

## Conditional Access

Implemented two Conditional Access policies:

- `CA-NRG-Require-MFA-Pilot`
- `CA-NRG-Block-LegacyAuth-Pilot`

Both policies were first validated in Report-only mode before enforcement.

Live testing confirmed:
- MFA was successfully enforced for the pilot group
- Microsoft Authenticator challenge completed successfully
- Legacy authentication policy evaluates to Block access
- Emergency-access accounts remain excluded

**Result:** PASS

---

## Privileged Identity Management

Configured Alex Morgan Admin as permanently eligible, but not permanently active, for the User Administrator role.

Activation requires:
- MFA
- Justification
- Approval
- Maximum 1-hour activation

Validated the full JIT lifecycle:

`Eligible → Request → Approval → Activated → Privileged Action → Deactivated`

PIM audit history confirmed the workflow.

**Result:** PASS

---

## Identity Governance

Created access reviews for the privileged-role eligibility group.

Validated:
- Required privileged access was approved
- Inappropriate contractor access was denied
- Review results were applied
- Contractor access was successfully removed
- Identity Governance recorded the remediation

**Result:** PASS

---

## Azure RBAC

Validated Azure authorization at:

`rg-nrg-ztpa-dev-eus-001`

Reader testing:
- Resource read → Allowed
- Resource modification → Denied

Contributor testing:
- Resource modification → Allowed
- RBAC role assignment → Denied

Broad Contributor access was removed after validation.

**Result:** PASS

---

## Custom Least-Privilege Role

Created:

`NRG NSG Security Rule Operator`

The role permits management of NSG security rules without permitting deletion of the parent NSG or modification of Azure RBAC.

Testing confirmed:
- Create security rule → Allowed
- Delete security rule → Allowed
- Delete NSG → Denied

**Result:** PASS

---

## Audit and Monitoring

Validated audit visibility across both control planes.

Microsoft Entra recorded:
- PIM eligibility and activation
- Approval workflow
- Identity Governance activity
- Conditional Access evaluation

Azure Activity Log recorded:
- RBAC changes
- NSG operations
- Security-rule operations
- Successful and failed authorization attempts

**Result:** PASS

---

## Final Validation

Automated validation confirmed:

- Azure test resources exist
- Temporary test rule removed
- Reader access remains correctly assigned
- Broad Contributor access removed
- Custom least-privilege role assigned
- Custom role definition exists
- Privileged group contains only the approved admin identity

**Overall Result: PASS**

---

## Security Handling

No passwords, temporary credentials, tenant IDs, subscription IDs, or other sensitive identifiers are intended for public source control.

Evidence screenshots were cropped or redacted where required.

---

## Outcome

Project 2 demonstrates practical Zero Trust identity security using Microsoft Entra ID and Azure, including Conditional Access, MFA, PIM, access reviews, group-based RBAC, custom least-privilege roles, authorization testing, and audit validation.