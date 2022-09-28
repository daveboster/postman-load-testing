# Postman Load testing
This is a proof of concept for taking API calls using the Postman collections to quickly perform load testing on software environments.

## Prerequisites
- [Postman Installation](https://www.postman.com/downloads/)
- [Install Grafana K6](https://k6.io/docs/getting-started/installation/)

## Sample DotNet API
1. [Install .Net 6](https://learn.microsoft.com/en-us/dotnet/core/install/macos)
    1. macOS example: `brew install --cask dotnet-sdk`
1. Create folder "TaskSample" and inside, olution file `dotnet new sln`.
1. Create class library `dotnet new classlib -n TaskSample.Tasks`.
1. Add library to the solution `dotnet sln add TaskSample.Tasks/TaskSample.Tasks.csproj`
1. Build the solution `dotnet build TaskSample.sln`
1. Run unit tests `dotnet test`
1. Add library to expose as an api `dotnet new webapi -minimal -o TaskApi`
1. Add reference to Task project `dotnet add reference ../Task/Task.csproj`
1. `dotnet dev-certs https --trust`
1. `dotnet run --project TaskApi/TaskApi.csproj`
1. https://localhost:7053/swagger/index.html (test weather)
1. remove weather and add method for Task API
1. update `.gitignore` file with `dotnet new gitignore --force`

## References
- [Postman](https://www.postman.com) - an API platform for building and using APIs.
- [Newman](https://github.com/postmanlabs/newman) - a command-line collection runner for Postman.
- [Grafana k6]() - an open-source load testing tool that makes performance testing easy and productive for engineering teams. k6 is free, developer-centric, and extensible.
- [postman-to-k6](https://github.com/apideck-libraries/postman-to-k6) - utilizes Postman collections and converts Postman requests, including tests, variables, ... to K6 scripts that can be executed by K6 to run performance tests.
- [Tutorial: Create a minimal web API with ASP.NET Core](https://learn.microsoft.com/en-us/aspnet/core/tutorials/min-web-api?view=aspnetcore-6.0&tabs=visual-studio-code)

### VS Code Extensions
- [C# for Visual Studio Code (powered by OmniSharp)](https://marketplace.visualstudio.com/items?itemName=ms-dotnettools.csharp)
