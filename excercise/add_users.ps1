Import-Module Microsoft.Graph.Users
connect-MgGraph -ClientId $global:ClientID -TenantId $global:TenantID -CertificateThumbprint "76248860FFFBD70513FBD16BE80C71644361BED3"
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