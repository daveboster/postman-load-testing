# Postman Load testing

This is a proof of concept for taking API calls using the Postman collections to quickly perform load testing on software environments.

## Prerequisties

- [Postman Installation](https://www.postman.com/downloads/)
- [Install Grafana K6](https://k6.io/docs/getting-started/installation/)

## Sample DotNet API

1. [Download .Net](https://dotnet.microsoft.com/en-us/download/dotnet) and [installation docs](https://learn.microsoft.com/en-us/dotnet/core/install/).
    - macOS note: use installer
2. Create folder "TaskSample" and inside, solution file `dotnet new sln`.
3. Create class library `dotnet new classlib -n TaskSample.Tasks`.
4. Add library to the solution `dotnet sln add TaskSample.Tasks/TaskSample.Tasks.csproj`
5. Build the solution `dotnet build TaskSample.sln`
6. Run unit tests `dotnet test`
7. Add library to expose as an api `dotnet new webapi -minimal -o TaskApi`
8. Add reference to Task project `dotnet add reference ../Task/Task.csproj`
9. `dotnet dev-certs https --trust`
10. `dotnet run --project TaskApi/TaskApi.csproj`
11. `https://localhost:7053/swagger/index.html` (test weather)
12. remove weather and add method for Task API
13. update `.gitignore` file with `dotnet new gitignore --force`

## References

- [Postman](https://www.postman.com) - an API platform for building and using APIs.
- [Newman](https://github.com/postmanlabs/newman) - a command-line collection runner for Postman.
- [Comparing Postman CLI and Newman](https://learning.postman.com/docs/postman-cli/postman-cli-overview/)
- [Grafana k6](https://k6.io) - an open-source load testing tool that makes performance testing easy and productive for engineering teams. k6 is free, developer-centric, and extensible.
- [postman-to-k6](https://github.com/apideck-libraries/postman-to-k6) - utilizes Postman collections and converts Postman requests, including tests, variables, ... to K6 scripts that can be executed by K6 to run performance tests.
- [Tutorial: Create a minimal web API with ASP.NET Core](https://learn.microsoft.com/en-us/aspnet/core/tutorials/min-web-api?view=aspnetcore-6.0&tabs=visual-studio-code)

### VS Code Extensions

Recommended extensions have been moved to the `.vscode/extensions.json` file.
