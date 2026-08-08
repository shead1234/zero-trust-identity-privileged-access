# Northstar Retail Group - Project 2
# Final technical validation for Azure RBAC and least-privilege controls.

$Rg = "rg-nrg-ztpa-dev-eus-001"
$Nsg = "nsg-nrg-ztpa-dev-eus-001"

$ReaderGroup = "SG-NRG-Azure-Readers"
$ContributorGroup = "SG-NRG-Azure-Contributors"
$ItOpsGroup = "SG-NRG-IT-Operations"
$PrivilegedGroup = "SG-NRG-Privileged-Role-Eligible"

$CustomRole = "NRG NSG Security Rule Operator"

function Write-Check {
    param(
        [string]$Name,
        [bool]$Passed
    )

    if ($Passed) {
        Write-Host "[PASS] $Name"
    }
    else {
        Write-Host "[FAIL] $Name"
    }
}

Write-Host ""
Write-Host "Project 2 - Final Technical Validation"
Write-Host "======================================"
Write-Host ""

# Resource group
$RgExists = az group exists --name $Rg
Write-Check "Project resource group exists" ($RgExists -eq "true")

# NSG
$NsgName = az network nsg show `
    --resource-group $Rg `
    --name $Nsg `
    --query name `
    -o tsv 2>$null

Write-Check "Project NSG exists" ($NsgName -eq $Nsg)

# Temporary validation rule cleanup
$TestRule = az network nsg rule show `
    --resource-group $Rg `
    --nsg-name $Nsg `
    --name "Deny-Test-Traffic" `
    --query name `
    -o tsv 2>$null

Write-Check "Temporary NSG validation rule removed" (-not $TestRule)

# Scope
$RgId = az group show `
    --name $Rg `
    --query id `
    -o tsv

# Reader assignment
$ReaderGroupId = az ad group show `
    --group $ReaderGroup `
    --query id `
    -o tsv

$ReaderRoles = az role assignment list `
    --assignee $ReaderGroupId `
    --scope $RgId `
    -o json | ConvertFrom-Json

$HasReader = @($ReaderRoles).roleDefinitionName -contains "Reader"

Write-Check "Azure Readers group has Reader role" $HasReader

# Contributor should no longer be assigned
$ContributorGroupId = az ad group show `
    --group $ContributorGroup `
    --query id `
    -o tsv

$ContributorRoles = az role assignment list `
    --assignee $ContributorGroupId `
    --scope $RgId `
    -o json | ConvertFrom-Json

$HasContributor = @($ContributorRoles).roleDefinitionName -contains "Contributor"

Write-Check "Broad Contributor assignment removed" (-not $HasContributor)

# Custom role assignment
$ItOpsGroupId = az ad group show `
    --group $ItOpsGroup `
    --query id `
    -o tsv

$ItOpsRoles = az role assignment list `
    --assignee $ItOpsGroupId `
    --scope $RgId `
    -o json | ConvertFrom-Json

$HasCustomRole = @($ItOpsRoles).roleDefinitionName -contains $CustomRole

Write-Check "IT Operations has custom least-privilege role" $HasCustomRole

# Custom role definition
$RoleDefinition = az role definition list `
    --name $CustomRole `
    -o json | ConvertFrom-Json

Write-Check "Custom NSG role definition exists" (@($RoleDefinition).Count -gt 0)

# Privileged eligibility group membership
$PrivilegedMembers = az ad group member list `
    --group $PrivilegedGroup `
    --query "[].displayName" `
    -o json | ConvertFrom-Json

$CorrectPrivilegedMembership = (
    @($PrivilegedMembers).Count -eq 1 -and
    $PrivilegedMembers[0] -eq "Alex Morgan Admin"
)

Write-Check "Privileged eligibility group contains only Alex Morgan Admin" $CorrectPrivilegedMembership

Write-Host ""
Write-Host "Validation complete."