. .\variables.ps1


####################################################
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
	$tokenEndpointUri = "https://login.microsoftonline.com/$TenantID/oauth2/token"

	# Get the access token using grant type client_credentials for Application Permissions
	$content = "grant_type=client_credentials&client_id=$ClientID&client_secret=$ClientSecret&resource=$resource"
	$response = Invoke-RestMethod -Uri $tokenEndpointUri -Body $content -Method Post -UseBasicParsing

	# If the accesstoken is valid then create the authentication header
	if($response.access_token)
        {
            Write-Host "Got new Access Token!" -ForegroundColor Green
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
Function Validate-AuthToken{
	# Checking if authToken exists before running authentication
	if($global:authToken){
		# Setting DateTime to Universal time to work in all timezones
		#$DateTime = (Get-Date).ToUniversalTime()
		$CurrentTimeUnix = $((get-date ([DateTime]::UtcNow) -UFormat +%s)).split((Get-Culture).NumberFormat.NumberDecimalSeparator)[0]
		# If the authToken exists checking when it expires
		#$TokenExpires = ($authToken.ExpiresOn.datetime - $DateTime).Minutes
		$TokenExpires = [MATH]::floor(([int]$global:authToken.ExpiresOn - [int]$CurrentTimeUnix) / 60)
		if($TokenExpires -le 0){
			write-host "Authentication Token expired" $TokenExpires "minutes ago" -ForegroundColor Yellow
			$global:authToken = Get-AuthToken -TenantID $global:TenantID -ClientID $global:ClientID -ClientSecret $global:ClientSecret
		}
	}
	# Authentication doesn't exist, calling Get-AuthToken function
	else {
		# Getting the authorization token
		$global:authToken = Get-AuthToken -TenantID $global:TenantID -ClientID $global:ClientID -ClientSecret $global:ClientSecret
	}
}

####################################################

$authtoken = get-authtoken -TenantID $TenantId -ClientID $ClientId -ClientSecret $ClientSecret

# Write-Host $authtoken

$uri = "https://graph.microsoft.com/beta/deviceManagement/deviceCompliancePolicies"

$result = Invoke-RestMethod -uri $uri -Headers $authtoken -Method GET