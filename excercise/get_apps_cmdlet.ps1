
Import-Module Microsoft.Graph.Beta.Devices.CorporateManagement
. .\variables.ps1

Connect-MgGraph -ClientId $ClientId -TenantId $TenantId -CertificateThumbprint $Thumbprint 

Get-MgContext | Format-Table -Wrap

Get-MgContext | Select-Object Scopes -ExpandProperty Scopes

Get-MgDeviceAppManagementMobileApp -MobileAppId "392d2b4b-b923-4e78-93e6-1c0cddb65144"  | Format-List
# Get-MgDeviceAppManagementMobileApp | Format-List


# Get-MgUser -Filter "displayName eq 'asif'" 

Disconnect-MgGraph


