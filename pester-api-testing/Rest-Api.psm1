# Credit to [Derek Graham](https://github.com/deejaygraham) for the original code
# https://deejaygraham.github.io/2019/05/27/using-pester-for-api-testing/

# Add -SkipHttpErrorCheck to Invoke-RestMethod to avoid throwing an exception on non-200 responses

Set-StrictMode -Version Latest

[string]$script:BaseUrl =  'https://localhost:7053/'
[hashtable]$script:Headers = @{ }


Function Set-ApiBaseUrl {
    [CmdletBinding()]
    Param (
		[Parameter(Mandatory=$True)]
        [ValidateNotNullOrEmpty()]
		[string]$Url
    )
	
	Write-Verbose "Changing api url to $Url"
	
	$script:BaseUrl = $Url
}

<#
.SYNOPSIS
Submit a GET request to the specified resource
#>
Function Get-ApiResource {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory=$True, Position=0)]
        [string]$Resource
    )

    $Response = Invoke-RestMethod -Method Get -Uri "$($script:BaseUrl)$Resource" -SkipHttpErrorCheck

    Write-Output $Response
}   

<#
.SYNOPSIS
Submit a POST request to the specified resource
#>
Function Add-ApiResource {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$True)]
        [string]$Resource,

    	[Parameter(Mandatory=$False)]
	    [hashtable]$Body,

        [Parameter(Mandatory=$False)]
        [hashtable]$Headers
    )
    
    if($Body) {
        $Json = $Body | ConvertTo-Json
        $Response = Invoke-WebRequest -Method Post -Uri "$($script:BaseUrl)$Resource" -Body $Json -Headers $Headers -SkipHttpErrorCheck 
    } else {
        $Response = Invoke-WebRequest -Method Post -Uri "$($script:BaseUrl)$Resource" -Headers $Headers -SkipHttpErrorCheck 
    }

    Write-Output $Response
}
