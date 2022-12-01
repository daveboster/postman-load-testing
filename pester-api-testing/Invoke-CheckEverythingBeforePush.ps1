# Can run before push

# Pass Helper Module Unit/Integration Tests with Prod API
& "$PSScriptRoot/Invoke-RestApi-Tests.ps1" -IntegrationBaseUrl 'https://localhost:7053/'                                                                                                   
& "$PSScriptRoot/Invoke-RestApi-Tests.ps1" -IntegrationBaseUrl 'https://postman-load-test.azurewebsites.net/'                                                                                                   

# Pass Smoke Tests Unit/Integration Tests with Local API
& "$PSScriptRoot/Invoke-ApiSmokeTests.ps1" -IntegrationBaseUrl 'https://localhost:7053/'                                                                                                   
& "$PSScriptRoot/Invoke-ApiSmokeTests.ps1" -IntegrationBaseUrl 'https://postman-load-test.azurewebsites.net/'    