. .\variables.ps1


Import-Module Microsoft.Graph.Users
connect-MgGraph -ClientId $ClientId -TenantId $TenantId -CertificateThumbprint $Thumbprint
$users = "veena", "swapnali", "Rahul"
$params = @{
    accountEnabled = $true
    displayName = "TestUserDemo2"
    mailNickName = "TestUseDemo22"
    userPrincipalName = "TestUserDemo2@spacenet.pro"
    usageLocation = "IN"
    passwordProfile = @{
        forceChangePasswordNextSignIn = $true
        password = "DemoPassword1!"
            }
    }

New-MgUser -BodyParameter $params