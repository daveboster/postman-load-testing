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

    function When([string]$A, [string]$Creates, [hashtable]$With) {
        $headerAssumptions = @{'Accept' = 'application/json'; 'Content-Type' = 'application/json'};
        $result = Add-ApiResource -Resource $Creates -Body $With -Headers $headerAssumptions
        return $result
    }
}

Describe "Creating Tasks for v1 '$IntegrationBaseUrl'" {
    BeforeAll {
        $expectedTitle = "Test";

        $response = Add-ApiResource "tasks/create?title=$($expectedTitle)"
        Write-Verbose "Response: $response"
    }

    It 'It should return a successful response' {
        $response.StatusCode | Should -Be 200
    }

    It 'It should return a task with our title' {
        $task = $response.Content | ConvertFrom-Json
        $task.title | Should -Be $expectedTitle
    }
}

Describe "Creating Tasks for v2 '$IntegrationBaseUrl'" {
    BeforeAll {
        # Given a
        $UserNamedEnola = "eholmes"
        # has a
        $BriefDescriptionOfWorkToBeDone = "Complete the Pester API Testing Module"
        # and wants to Track
        $ANewTask = "tasks";
        # to track it's completion.

        $Then = When -A $UserNamedEnola -Creates $ANewTask -With @{ title=$BriefDescriptionOfWorkToBeDone }
        Write-Verbose "Then: $Then" # Prevent unused variable warning 😬

    }

    # Then
    It 'Should return a created status code' {
        $Then.StatusCode | Should -Be 201 -Because "it is the correct response code for creating objects"
        # see https://learn.microsoft.com/en-us/aspnet/core/fundamentals/minimal-apis?view=aspnetcore-7.0#built-in-results
        # see https://www.rfc-editor.org/rfc/rfc9110.html#status.201
    }

    It 'Should return a location header for the newly created task' {
        $Then.Headers.Location | Should -BeLike "*tasks/*" -Because "it indicates the location for the new record"
        # see https://www.rfc-editor.org/rfc/rfc9110.html#status.201
    }

    It 'Should return a task with our title' {
        $Then.Content | ConvertFrom-Json | Select-Object -ExpandProperty title | Should -Be $BriefDescriptionOfWorkToBeDone `
            -Because "the title should match the one we sent"
        # see 'cause duh' 😂 (have to let some dev sacasm slip in)
    }

}

Describe "API should provide Swagger for API Discovery and Management" {
    It 'Should return a 200 status code fpom the swagger endpoint' {
        $response = Invoke-WebRequest -Uri "$($IntegrationBaseUrl)swagger/index.html"
        $response.StatusCode | Should -Be 200
    }
}