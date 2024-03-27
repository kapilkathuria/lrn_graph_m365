. .\variables.ps1

Function Get-AuthToken {
	param(
		[Parameter(Mandatory=$true)]
		$TenantID,
		[Parameter(Mandatory=$true)]
		$ClientID,
		[Parameter(Mandatory=$true)]
		$ClientSecret
	)
	
  $resource = "https://graph.microsoft.com"
	$authority = "https://login.microsoftonline.com/$TenantID"
	$tokenEndpointUri = "$authority/oauth2/token"

	# Get the access token using grant type client_credentials for Application Permissions
	$content = "grant_type=client_credentials&client_id=$ClientID&client_secret=$ClientSecret&resource=$resource"
	$response = Invoke-RestMethod -Uri $tokenEndpointUri -Body $content -Method Post -UseBasicParsing
	Write-Host "Got new Access Token!" -ForegroundColor Green

	# If the accesstoken is valid then create the authentication header
	if($response.access_token)
        {
	        # Creating header for Authorization token
	        $authHeader = @{
		        'Content-Type'='application/json'
		        'Authorization'="Bearer " + $response.access_token
		        'ExpiresOn'=$response.expires_on
		    }
	    return $authHeader
	    }
	else
        {
		    Write-Error "Authorization Access Token is null, check that the client_id and client_secret is correct..."
		    break
	    }
}
####################################################
$authtoken = $null
$authtoken = get-authtoken -TenantID $TenantId -ClientID $ClientId -ClientSecret $ClientSecret

# $body = @{
# 	# @odata.type = "#microsoft.graph.windowsMobileMSI",
# 	categories = [],
# 	commandLine = "",
# 	description = "Node.js",
# 	developer = "",
# 	displayName = "Nove v20 3rd",
# 	fileName = "node-v20.12.0-x64.msi",
# 	identityVersion = "20.12.0",
# 	ignoreVersionDetection = false,
# 	informationUrl = "",
# 	isFeatured = false,
# 	roleScopeTagIds = [],
# 	notes = "",
# 	owner = "",
# 	privacyInformationUrl = "",
# 	productCode = "{5E3890DD-9531-4B91-A2AB-BD8A3366990A}",
# 	productVersion = "20.12.0",
# 	publisher = "Node"
# }

$body = @{
	"@odata.type" = "#microsoft.graph.androidLobApp"
	displayName = "Display Name value"
	description = "Description value"
	publisher = "Publisher value"
}

# Convert the request body to JSON
$jsonBody = $body | ConvertTo-Json

# $uri = "https://graph.microsoft.com/beta/deviceManagement/deviceCompliancePolicies"
# $uri = "https://graph.microsoft.com/v1.0/deviceAppManagement/mobileApps"
$uri = "https://graph.microsoft.com/v1.0/deviceAppManagement/mobileApps"

$result = $null
$result = Invoke-RestMethod -uri $uri -Headers $authtoken -Method Post -Body $jsonBody

$result.value | Format-Table



