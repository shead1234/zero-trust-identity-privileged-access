# Northstar Retail Group - Project 2
# Assigns Microsoft Entra ID P2 licenses to lab users.
# Break-glass accounts are intentionally left unlicensed.

$DomainsUrl = 'https:' + '//' + 'graph.microsoft.com/v1.0/domains'
$SkuUrl     = 'https:' + '//' + 'graph.microsoft.com/v1.0/subscribedSkus'

$DomainData = az rest --method GET --url $DomainsUrl -o json | ConvertFrom-Json
$Domain = ($DomainData.value | Where-Object { $_.isDefault -eq $true }).id

$SkuData = az rest --method GET --url $SkuUrl -o json | ConvertFrom-Json
$P2Sku = $SkuData.value | Where-Object { $_.skuPartNumber -eq "AAD_PREMIUM_P2" }

if (-not $Domain) {
    throw "Unable to determine tenant domain."
}

if (-not $P2Sku) {
    throw "Microsoft Entra ID P2 license was not found."
}

$Users = @(
    "alex.morgan",
    "adm-alex.morgan",
    "maya.chen",
    "daniel.brooks",
    "priya.shah",
    "ctr-jordan.lee"
)

foreach ($Username in $Users) {

    $UPN = "$Username@$Domain"

    $UserId = az ad user show `
        --id $UPN `
        --query id `
        -o tsv

    if (-not $UserId) {
        Write-Host "USER NOT FOUND: $Username"
        continue
    }

    # --------------------------------------------------
    # Set Usage Location
    # --------------------------------------------------

    $UserUrl = 'https:' + '//' + "graph.microsoft.com/v1.0/users/$UserId"

    $LocationFile = Join-Path $env:TEMP "nrg-location.json"

    @{
        usageLocation = "US"
    } |
        ConvertTo-Json |
        Set-Content -Path $LocationFile -Encoding utf8

    az rest `
        --method PATCH `
        --url $UserUrl `
        --headers "Content-Type=application/json" `
        --body "@$LocationFile" `
        --output none

    if ($LASTEXITCODE -ne 0) {
        Write-Host "FAILED setting usage location: $Username"
        continue
    }

    # --------------------------------------------------
    # Assign P2
    # --------------------------------------------------

    $LicenseUrl = 'https:' + '//' + "graph.microsoft.com/v1.0/users/$UserId/assignLicense"

    $LicenseFile = Join-Path $env:TEMP "nrg-license.json"

    @{
        addLicenses = @(
            @{
                skuId         = "$($P2Sku.skuId)"
                disabledPlans = @()
            }
        )
        removeLicenses = @()
    } |
        ConvertTo-Json -Depth 5 |
        Set-Content -Path $LicenseFile -Encoding utf8

    az rest `
        --method POST `
        --url $LicenseUrl `
        --headers "Content-Type=application/json" `
        --body "@$LicenseFile" `
        --output none

    if ($LASTEXITCODE -eq 0) {
        Write-Host "P2 assigned: $Username"
    }
    else {
        Write-Host "FAILED assigning P2: $Username"
    }
}

Remove-Item "$env:TEMP\nrg-location.json" -ErrorAction SilentlyContinue
Remove-Item "$env:TEMP\nrg-license.json" -ErrorAction SilentlyContinue

Write-Host ""
Write-Host "P2 licensing complete."