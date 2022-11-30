BeforeAll {
    # Add '-Verbose' to the Module commands to see what it's doing
    $moduleUnderTest = "Rest-Api"
    
    # For troubleshooting, try uncommenting to remove module to ensure proper clean-up
    #Get-Module -Name "$moduleUnderTest.psm1" -All  | Remove-Module -Force -ErrorAction Ignore

    # Import Module Under Test
    Import-Module "$PSScriptRoot/$moduleUnderTest.psm1" -Force 
}

Describe 'Add-ApiResource' {
    BeforeEach {
        $commandUnderTest = "Add-ApiResource"
    }

    It "Should provide help synopsis that is not auto-generated" {
        $help = Get-Command -CommandType Function -Name $commandUnderTest | Get-Help -ErrorAction SilentlyContinue
        $help.Synopsis | Should -Not -BeNullOrEmpty
        $help.Synopsis | Should -Not -BeLike "`n$commandUnderTest `n"
    }

    It "Should require a parameter named 'Resource'" {
        (Get-Command $commandUnderTest).Parameters['Resource'].Attributes.Mandatory | Should -BeTrue
    }

    It "Should allow an optional parameter 'Body' to send as content" {
        (Get-Command $commandUnderTest).Parameters['Body'].Attributes.Mandatory | Should -BeFalse
    }
}