# micrsoft's graph module
# Install-Module Microsoft.Graph -Force

Import-Module Microsoft.Graph.Users

# select api version
Select-MgProfile -Name "beta"

# Find api
Find-MgGraphCommand -Uri '/users'
Find-MgGraphCommand -Uri '/users' | Select-Object -First 1 -ExpandProperty Permissions

# Find graph modules
get-command -Module Microsoft.Graph*

# connect to graph
Connect-MgGraph
Connect-MgGraph -Scopes "User.Read.All"

# check context and role of current user
Get-MgContext