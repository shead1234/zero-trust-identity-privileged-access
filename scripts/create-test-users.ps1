# Northstar Retail Group - Project 2
# Creates fictional cloud-only identities for the Zero Trust lab.
# Passwords are generated at runtime and are NOT stored in the Git repository.

$DomainsUrl = 'https:' + '//' + 'graph.microsoft.com/v1.0/domains'
$DomainData = az rest --method GET --url $DomainsUrl -o json | ConvertFrom-Json
$Domain = ($DomainData.value | Where-Object { $_.isDefault -eq $true }).id

if (-not $Domain) {
    throw "Unable to determine the default Microsoft Entra domain."
}

Write-Host "Using active Microsoft Entra tenant domain."

$Users = @(
    @{ DisplayName = "Alex Morgan";          Username = "alex.morgan" },
    @{ DisplayName = "Alex Morgan Admin";    Username = "adm-alex.morgan" },
    @{ DisplayName = "Maya Chen";            Username = "maya.chen" },
    @{ DisplayName = "Daniel Brooks";        Username = "daniel.brooks" },
    @{ DisplayName = "Priya Shah";           Username = "priya.shah" },
    @{ DisplayName = "Jordan Lee";            Username = "ctr-jordan.lee" },
    @{ DisplayName = "Break Glass Admin 01"; Username = "bg-admin01" },
    @{ DisplayName = "Break Glass Admin 02"; Username = "bg-admin02" }
)

function New-TemporaryPassword {

    $Upper = [char](Get-Random -Minimum 65 -Maximum 91)
    $Lower = [char](Get-Random -Minimum 97 -Maximum 123)
    $Digit = Get-Random -Minimum 0 -Maximum 10

    $SpecialChars = '!@#$%&*?'.ToCharArray()
    $SpecialIndex = Get-Random -Minimum 0 -Maximum $SpecialChars.Count
    $Special = $SpecialChars[$SpecialIndex]

    $Rest = -join (
        1..16 | ForEach-Object {
            [char](Get-Random -Minimum 97 -Maximum 123)
        }
    )

    return "$Upper$Lower$Digit$Special$Rest"
}

$CreatedUsers = @()

foreach ($User in $Users) {

    $UPN = "$($User.Username)@$Domain"

    $Existing = az ad user show --id $UPN --query id -o tsv 2>$null

    if ($Existing) {
        Write-Host "Already exists: $($User.DisplayName)"
        continue
    }

    $TempPassword = New-TemporaryPassword

    az ad user create `
        --display-name $User.DisplayName `
        --user-principal-name $UPN `
        --password $TempPassword `
        --force-change-password-next-sign-in true `
        --output none

    if ($LASTEXITCODE -eq 0) {

        $CreatedUsers += [PSCustomObject]@{
            DisplayName       = $User.DisplayName
            UserPrincipalName = $UPN
            TemporaryPassword = $TempPassword
        }

        Write-Host "Created: $($User.DisplayName)"
    }
    else {
        Write-Host "FAILED: $($User.DisplayName)"
    }
}

if ($CreatedUsers.Count -gt 0) {

    $SecretFile = Join-Path $env:USERPROFILE "Project2-Temporary-Passwords.txt"

    $CreatedUsers |
        Format-Table -AutoSize |
        Out-String |
        Set-Content $SecretFile

    Write-Host ""
    Write-Host "Temporary passwords saved OUTSIDE the Git repository:"
    Write-Host $SecretFile
}

Write-Host ""
Write-Host "User creation complete."