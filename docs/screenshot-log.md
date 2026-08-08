# Evidence Screenshot Log

Evidence screenshots are stored in `evidence/screenshots/`. Sensitive identifiers are redacted where appropriate.

| # | Screenshot | Evidence |
|---|---|---|
| 01 | `01-security-groups-created.png` | Project security groups created |
| 02 | `02-security-groups-verified.png` | Security-group inventory verified |
| 03 | `03-test-identities-created.png` | Fictional cloud identities created |
| 04 | `04-group-memberships-configured.png` | Role-based group memberships configured |
| 05 | `05-p2-licenses-assigned.png` | Entra ID P2 licenses assigned |
| 06 | `06-break-glass-admin01-global-admin.png` | Break Glass Admin 01 assigned Global Administrator |
| 07 | `07-break-glass-admin02-global-admin.png` | Break Glass Admin 02 assigned Global Administrator |
| 08 | `08-conditional-access-mfa-pilot-report-only.png` | MFA policy configured in Report-only mode |
| 09 | `09-mfa-pilot-report-only-signin-result.png` | MFA policy evaluated during sign-in |
| 10 | `10-conditional-access-legacy-auth-report-only.png` | Legacy-authentication policy configured in Report-only mode |
| 11 | `11-legacy-auth-what-if-block-result.png` | Legacy-authentication What If test returned Block access |
| 12 | `12-pim-alex-admin-eligible-user-administrator.png` | Admin identity assigned PIM eligibility |
| 13 | `13-pim-user-admin-activation-controls.png` | PIM activation security controls configured |
| 14 | `14-pim-alex-admin-eligible-activate.png` | Admin identity eligible to activate User Administrator |
| 15 | `15-pim-activation-request-pending.png` | PIM activation request submitted |
| 16 | `16-pim-activation-request-awaiting-approval.png` | Activation request awaiting approval |
| 17 | `17-pim-user-admin-active-after-approval.png` | User Administrator activated after approval |
| 18 | `18-pim-authorized-user-creation.png` | Authorized privileged user-management activity recorded |
| 19 | `19-pim-role-deactivated-still-eligible.png` | Privileged role deactivated and returned to eligible state |
| 20 | `20-access-review-privileged-group-created.png` | Privileged-access review created |
| 21 | `21-access-review-active-one-user.png` | Access review active with user in scope |
| 22 | `22-access-review-approved.png` | Legitimate privileged access approved |
| 23 | `23-access-review-stale-access-two-users.png` | Cleanup review identified two users |
| 24 | `24-access-review-approved-and-denied.png` | Required access approved and contractor access denied |
| 25 | `25-access-review-denied-user-removed.png` | Denied contractor removed from privileged group |
| 26 | `26-azure-rbac-test-scope-created.png` | Azure RBAC validation resources created |
| 27 | `27-azure-reader-group-assignment.png` | Reader role assigned through security group |
| 28 | `28-reader-authorized-read-success.png` | Reader successfully viewed Azure resource |
| 29 | `29-reader-unauthorized-write-denied.png` | Reader modification attempt denied |
| 30 | `30-azure-contributor-group-assignment.png` | Contributor temporarily assigned through group |
| 31 | `31-contributor-authorized-write-success.png` | Contributor successfully modified resource |
| 32 | `32-contributor-rbac-assignment-denied.png` | Contributor blocked from assigning RBAC roles |
| 33 | `33-custom-nsg-role-definition.png` | Custom least-privilege NSG role created |
| 34 | `34-custom-role-group-assignment.png` | Custom role assigned to IT Operations |
| 35 | `35-custom-role-authorized-rule-create.png` | Custom role successfully created NSG security rule |
| 36 | `36-custom-role-nsg-delete-denied.png` | Custom role blocked from deleting parent NSG |
| 37 | `37-azure-activity-log-rbac-nsg-events.png` | Azure Activity Log captured RBAC and NSG events |
| 38 | `38-pim-audit-history.png` | PIM approval and activation audit history |
| 39 | `39-access-review-remediation-audit.png` | Identity Governance remediation audit event |
| 39.5 | `39.5-access-review-remediation-audit.png` | Additional remediation audit details and target verification |
| 40 | `40-conditional-access-mfa-enforced.png` | MFA Conditional Access policy enabled |
| 41 | `41-mfa-enforcement-success.png` | Enforced MFA Conditional Access evaluation succeeded |
| 42 | `42-legacy-auth-block-enforced.png` | Legacy-authentication blocking policy enabled |
| 43 | `43-final-technical-validation.png` | Final automated validation returned all PASS results |

## Evidence Handling

Screenshots demonstrate security controls and validation outcomes without intentionally exposing credentials or sensitive environment identifiers.