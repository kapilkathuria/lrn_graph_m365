
Import-Module Microsoft.Graph.Users
. .\variables.ps1

Connect-MgGraph -ClientId $ClientId -TenantId $TenantId -CertificateThumbprint $Thumbprint 

Get-MgContext

Get-MgUser | Format-Table

Get-MgUser -Filter "displayName eq 'asif'" 

Disconnect-MgGraph
