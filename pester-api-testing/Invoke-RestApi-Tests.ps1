# Example: ./pester-api-testing/Invoke-RestApi-Tests.ps1 -IntegrationBaseUrl 'https://localhost:7053/' -PassThru                                                                                                     
# Example: ./pester-api-testing/Invoke-RestApi-Tests.ps1 -IntegrationBaseUrl  'https://postman-load-test.azurewebsites.net/' -PassThru 
# Example: ./pester-api-testing/Invoke-RestApi-Tests.ps1                                                                                                   

param (
    [Parameter(Mandatory=$False)]
    [string] $IntegrationBaseUrl,

    [Parameter(Mandatory=$False)]
    [string] $Output = 'Detailed',

    [Parameter(Mandatory=$False)]
    [switch] $PassThru
)

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

Import-Module Pester

$container = New-PesterContainer -Path "$PSScriptRoot/Rest-Api.Tests.ps1" -Data @{ IntegrationBaseUrl = $IntegrationBaseUrl }
$pesterConfiguration = New-PesterConfiguration -Hashtable @{
    Run = @{ # Run configuration.
        Container = $container
        PassThru = $PassThru # Return result object after finishing the test run.
    }
    Output = @{
        Verbosity = $Output
    }
}

Invoke-Pester -Configuration $pesterConfiguration