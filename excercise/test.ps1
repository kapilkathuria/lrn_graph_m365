$graphApiVersion = "v1.0"
$Resource = "deviceAppManagement/mobileApps"
$uri = "https://graph.microsoft.com/$graphApiVersion/$($Resource)"
(Invoke-RestMethod -Uri $uri -Headers $authToken -Method Get).Value | `
Where-Object { ($_.'displayName').contains("$Name") -and (($_.'@odata.type').Contains("microsoft.graph.win32")) }