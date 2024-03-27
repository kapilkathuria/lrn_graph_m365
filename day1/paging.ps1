$i=0
 $uri = "https://graph.microsoft.com/$graphApiVersion/$($Resource)/'xyz'" 
    do {
        $i++
        $Result = Invoke-RestMethod -Uri $uri -Headers $global:authToken -Method Get
        $uri = $Result.'@odata.nextLink'
        write-host "Page $i"
        write-host "$uri"
	} while ($uri -ne $null)