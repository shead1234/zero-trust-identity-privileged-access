# Identity and Privileged-Access Architecture

## Project

**Zero Trust Identity and Privileged Access**

## Organization

**Northstar Retail Group**

## Architecture Objective

The identity architecture protects Microsoft Entra ID and Azure resources by separating everyday identities from administrative identities, assigning access through security groups, enforcing authentication controls, and limiting privileged access.

The architecture follows three Zero Trust principles:

1. Verify explicitly
2. Use least-privilege access
3. Assume breach

## Architecture Overview

The environment contains the following identity types:

- Standard employees
- Department-specific users
- Contractors
- External guests
- Separate administrator accounts
- Emergency-access accounts

Access is assigned primarily through Microsoft Entra security groups rather than directly to individual users.

## Architecture Diagram

```mermaid
flowchart TD
    A[Northstar Retail Group Identities]

    A --> B[Standard Employees]
    A --> C[Contractors]
    A --> D[External Guests]
    A --> E[Administrator Accounts]
    A --> F[Emergency-Access Accounts]

    B --> G[Department Security Groups]
    C --> H[Contractor Security Group]
    D --> I[Guest Auditor Security Group]
    E --> J[Privileged Eligible Group]
    F --> K[Conditional Access Exclusion Group]

    G --> L[Azure Reader or Application Access]
    H --> M[Temporary Limited Access]
    I --> N[Read-Only Audit Access]
    J --> O[Privileged Identity Management]
    K --> P[Emergency Tenant Recovery]

    B --> Q[Conditional Access]
    C --> Q
    D --> Q
    E --> Q

    Q --> R[Multifactor Authentication]
    Q --> S[Legacy Authentication Blocking]
    Q --> T[Administrator Protection]

    O --> U[Time-Limited Role Activation]
    O --> V[Justification]
    O --> W[Approval When Required]

    L --> X[Azure Resources]
    M --> X
    N --> X
    U --> X

    Q --> Y[Sign-In Logs]
    O --> Z[Audit and PIM Logs]