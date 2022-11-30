param (
    [Parameter(Mandatory=$False)]
    [string] $IntegrationBaseUrl
)

# Discovery Variables (see Pester phases)
$skipIntegrationTests = ($null -eq $IntegrationBaseUrl -or $IntegrationBaseUrl -eq '') #


BeforeAll {
    # Add '-Verbose' to the Module commands to see what it's doing
    $moduleUnderTest = "Rest-Api"
    
    # For troubleshooting, try uncommenting to remove module to ensure proper clean-up
    #Get-Module -Name "$moduleUnderTest.psm1" -All  | Remove-Module -Force -ErrorAction Ignore

    # Import Module Under Test
    Import-Module "$PSScriptRoot/$moduleUnderTest.psm1" -Force 

}

Describe 'Add-ApiResource' {
    Context 'Unit Tests'  -Tag 'unit' {
        BeforeAll {
            $commandUnderTest = "Add-ApiResource"
            Write-Verbose "Running Unit Tests for '$commandUnderTest'" # Prevent unused variable warning
        }

        It "Should provide help synopsis that is not auto-generated" {
            $help = Get-Command -CommandType Function -Name $commandUnderTest | Get-Help -ErrorAction SilentlyContinue
            $help.Synopsis | Should -Not -BeNullOrEmpty
            $Help.Synopsis | Should -Not -BeLike '*`[`<CommonParameters`>`]*'
        }

        It "Should require a parameter named 'Resource'" {
            (Get-Command $commandUnderTest).Parameters['Resource'].Attributes.Mandatory | Should -BeTrue
        }

        It "Should allow an optional parameter 'Body' to send as content" {
            (Get-Command $commandUnderTest).Parameters['Body'].Attributes.Mandatory | Should -BeFalse
        }

        It "Should return a StatusCode property with <_>" -ForEach 200, 404, 500 {
            Mock Invoke-WebRequest {
                @{
                    StatusCode = $_
                }
            } -Module $moduleUnderTest

            $response = Add-ApiResource -Resource "test"

            $response.StatusCode | Should -Be $_
        }

        It "Should return a Content property" {
            Mock Invoke-WebRequest {
                @{
                    Content = "{'title':'Test'}"
                }
            } -Module $moduleUnderTest

            $response = Add-ApiResource -Resource "test"

            $response.Content | Should -Be "{'title':'Test'}"
        }
    }

    Context 'Itegration Success Tests' -Skip:$skipIntegrationTests -Tag 'integration' {
        BeforeAll {
            # Set helper base-url from parameter
            Set-ApiBaseUrl -Url $IntegrationBaseUrl

            $expectedTitle = "Test";
            $response = Add-ApiResource "tasks/create?title=$($expectedTitle)"
            Write-Verbose "Response: $response" # Prevent unused variable warning
        }
    
        It 'It should return a successful response' {
            $response.StatusCode | Should -Be 200
        }
    
        It 'It should return a task with our title' {
            $task = $response.Content | ConvertFrom-Json
            $task.title | Should -Be $expectedTitle
        }
    }

    Context 'Itegration Failure Tests' -Skip:$skipIntegrationTests -Tag 'integration' {
        BeforeAll {
            # Set helper base-url from parameter
            Set-ApiBaseUrl -Url $IntegrationBaseUrl

            $response = Add-ApiResource "MayIHaveA404For1000PleaseAlex"
            Write-Verbose "Response: $response" # Prevent unused variable warning
        }
    
        It 'It should return a 404 response' {
            $response.StatusCode | Should -Be 404
        }
    }
}

Describe 'Get-ApiResource' {
    BeforeAll {
        $commandUnderTest = "Get-ApiResource"
        Write-Verbose "Running Unit Tests for '$commandUnderTest'" # Prevent unused variable warning
    }

    Context 'Unit Tests' -Tag 'unit' {
        It "Should provide help synopsis that is not auto-generated" {
            $help = Get-Command -CommandType Function -Name $commandUnderTest | Get-Help -ErrorAction SilentlyContinue
            $help.Synopsis | Should -Not -BeNullOrEmpty
            $Help.Synopsis | Should -Not -BeLike '*`[`<CommonParameters`>`]*'
        }

        It "Should require a parameter named 'Resource'" {
            (Get-Command $commandUnderTest).Parameters['Resource'].Attributes.Mandatory | Should -BeTrue
        }

        It "Should return a StatusCode property with <_>" -ForEach 200, 404, 500 {
            Mock Invoke-RestMethod {
                @{
                    StatusCode = $_
                }
            } -Module $moduleUnderTest

            $response = Get-ApiResource -Resource "test"

            $response.StatusCode | Should -Be $_
        }

        It "Should return a Content property" {
            Mock Invoke-RestMethod {
                @{
                    Content = "{'title':'Test'}"
                }
            } -Module $moduleUnderTest

            $response = Get-ApiResource -Resource "test"

            $response.Content | Should -Be "{'title':'Test'}"
        }
    }

    Context 'Itegration Failure Tests' -Skip:$skipIntegrationTests -Tag 'integration' {
        BeforeAll {
            # Set helper base-url from parameter
            Set-ApiBaseUrl -Url $IntegrationBaseUrl

            $response = Add-ApiResource "MayIHaveA404For1000PleaseAlex"
            Write-Verbose "Response: $response" # Prevent unused variable warning
        }
    
        It 'It should return a 404 response' {
            $response.StatusCode | Should -Be 404
        }
    }

}