$params = @{
	select = @(
		"DeviceName"
		"UserPrincipalName"
		"Platform"
		"AppVersion"
		"InstallState"
		"InstallStateDetail"
		"AssignmentFilterIdsExist"
		"LastModifiedDateTime"
		"DeviceId"
		"ErrorCode"
		"UserName"
		"UserId"
		"ApplicationId"
		"AssignmentFilterIdsList"
		"AppInstallState"
		"AppInstallStateDetails"
		"HexErrorCode"
	)
	skip = 0
	top = 50
	filter = "(ApplicationId eq '037c7c38-ecbb-4878-a883-3226745ef9de')"
	orderBy = @(
	)
}

$jsonbody = $params | ConvertTo-Json
$uri = "https://graph.microsoft.com/beta/deviceManagement/reports/getDeviceInstallStatusReport"
$result = Invoke-RestMethod -Uri $uri -Method Post -Body $jsonbody -Headers $authtoken