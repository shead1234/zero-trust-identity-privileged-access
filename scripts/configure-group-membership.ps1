# Northstar Retail Group - Project 2
# Configures group-based identity access for the Zero Trust lab.

$DomainsUrl = 'https:' + '//' + 'graph.microsoft.com/v1.0/domains'
$DomainData = az rest --method GET --url $DomainsUrl -o json | ConvertFrom-Json
$Domain = ($DomainData.value | Where-Object { $_.isDefault -eq $true }).id

if (-not $Domain) {
    throw "Unable to determine the default Microsoft Entra domain."
}

$Memberships = @(
    @{ User = "alex.morgan";       Group = "SG-NRG-All-Employees" },
    @{ User = "alex.morgan";       Group = "SG-NRG-IT-Operations" },

    @{ User = "adm-alex.morgan";   Group = "SG-NRG-Privileged-Role-Eligible" },
    @{ User = "adm-alex.morgan";   Group = "SG-NRG-CA-Admin-Protection" },

    @{ User = "maya.chen";         Group = "SG-NRG-All-Employees" },
    @{ User = "maya.chen";         Group = "SG-NRG-Security-Readers" },
    @{ User = "maya.chen";         Group = "SG-NRG-Azure-Readers" },

    @{ User = "daniel.brooks";     Group = "SG-NRG-All-Employees" },
    @{ User = "daniel.brooks";     Group = "SG-NRG-Finance-Users" },

    @{ User = "priya.shah";        Group = "SG-NRG-All-Employees" },
    @{ User = "priya.shah";        Group = "SG-NRG-HR-Users" },

    @{ User = "ctr-jordan.lee";    Group = "SG-NRG-Contractors" },

    @{ User = "bg-admin01";        Group = "SG-NRG-CA-Exclusions" },
    @{ User = "bg-admin02";        Group = "SG-NRG-CA-Exclusions" },

    # Conditional Access pilot users
    @{ User = "alex.morgan";       Group = "SG-NRG-CA-MFA-Users" },
    @{ User = "maya.chen";         Group = "SG-NRG-CA-MFA-Users" },

    @{ User = "alex.morgan";       Group = "SG-NRG-CA-LegacyAuth-Block" },
    @{ User = "maya.chen";         Group = "SG-NRG-CA-LegacyAuth-Block" }
)

foreach ($Membership in $Memberships) {

    $UPN = "$($Membership.User)@$Domain"

    $UserId = az ad user show `
        --id $UPN `
        --query id `
        -o tsv

    $GroupId = az ad group show `
        --group $Membership.Group `
        --query id `
        -o tsv

    if (-not $UserId) {
        Write-Host "USER NOT FOUND: $UPN"
        continue
    }

    if (-not $GroupId) {
        Write-Host "GROUP NOT FOUND: $($Membership.Group)"
        continue
    }

    $AlreadyMember = az ad group member check `
        --group $GroupId `
        --member-id $UserId `
        --query value `
        -o tsv

    if ($AlreadyMember -eq "true") {
        Write-Host "Already configured: $($Membership.User) -> $($Membership.Group)"
        continue
    }

    az ad group member add `
        --group $GroupId `
        --member-id $UserId

    if ($LASTEXITCODE -eq 0) {
        Write-Host "Added: $($Membership.User) -> $($Membership.Group)"
    }
    else {
        Write-Host "FAILED: $($Membership.User) -> $($Membership.Group)"
    }
}

Write-Host ""
Write-Host "Group membership configuration complete."