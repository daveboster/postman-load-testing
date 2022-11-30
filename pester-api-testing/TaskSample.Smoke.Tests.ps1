param (
    [Parameter(Mandatory)]
    [string] $IntegrationBaseUrl
)

BeforeAll {
    # Add '-Verbose' to the Module commands to see what it's doing
    # For troubleshooting, try uncommenting to remove module to ensure proper clean-up
    #Get-Module -Name "$moduleUnderTest.psm1" -All  | Remove-Module -Force -ErrorAction Ignore

    # Import Module Under Test
    Import-Module "$PSScriptRoot/Rest-Api.psm1" -Force

    # Set helper base-url from parameter
    Set-ApiBaseUrl -Url $IntegrationBaseUrl
}

Describe "Creating Tasks for '$IntegrationBaseUrl'" {
    BeforeAll {
        $expectedTitle = "Test";

        $response = Add-ApiResource "tasks/create?title=$($expectedTitle)"
    }

    It 'It should return a successful response' {
        $response.StatusCode | Should -Be 200
    }

    It 'It should return a task with our title' {
        $task = $response.Content | ConvertFrom-Json
        $task.title | Should -Be $expectedTitle
    }

}