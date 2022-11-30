[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

$here = Split-Path -Path $MyInvocation.MyCommand.Path
Import-Module $here/Rest-Api.psm1
Import-Module Pester

$BaseUrl = 'https://postman-load-test.azurewebsites.net/'

Set-ApiBaseUrl -Url $BaseUrl

Invoke-Pester "$here/*.Smoke.Tests.ps1" -Verbose:$VerbosePreference -PassThru
