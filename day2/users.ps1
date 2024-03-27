# micrsoft's graph module
# Install-Module Microsoft.Graph -Force

Import-Module Microsoft.Graph.Users

Connect-MgGraph -Scopes "User.Read.All"

# get list of users
Get-MgUser

Disconnect-MgGraph