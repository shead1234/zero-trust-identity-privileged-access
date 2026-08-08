# Northstar Retail Group - Project 2
# Creates a least-privilege Azure custom role for NSG security-rule management.

$Rg = "rg-nrg-ztpa-dev-eus-001"

$RgId = az group show `
    --name $Rg `
    --query id `
    -o tsv

if (-not $RgId) {
    throw "Unable to determine resource-group scope."
}

$TemplatePath = ".\roles\nsg-security-rule-operator.template.json"
$TempRolePath = Join-Path $env:TEMP "nrg-nsg-security-rule-operator.json"

$RoleJson = Get-Content $TemplatePath -Raw
$RoleJson = $RoleJson.Replace("__ASSIGNABLE_SCOPE__", $RgId)

$RoleJson | Set-Content $TempRolePath -Encoding utf8

az role definition create `
    --role-definition $TempRolePath `
    --output none

if ($LASTEXITCODE -eq 0) {
    Write-Host "Created custom role: NRG NSG Security Rule Operator"
}
else {
    throw "Custom role creation failed."
}

Remove-Item $TempRolePath -ErrorAction SilentlyContinue