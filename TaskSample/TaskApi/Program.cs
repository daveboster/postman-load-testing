using TaskSample.Task;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();

app.UseSwagger();
app.UseSwaggerUI();

app.UseHttpsRedirection();

// Version 1 (backwards compatible) -- don't break existing clients and our smoke tests shouldn't let you 😉
app.MapPost("/tasks/create", (string title) =>
{
    return new TaskSample.Task.Task(title);
});

// Version 2
app.MapPost("/tasks", (TaskSample.Task.Task newTask) =>
{
    return Results.Created("tasks/[taskidgoeshere]", new TaskSample.Task.Task(newTask.Title));
})
    .Accepts<TaskSample.Task.Task>("application/json")
    .Produces<TaskSample.Task.Task>(StatusCodes.Status201Created);

app.Run();
