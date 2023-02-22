namespace TaskSample.Task;

public class Task
{
    internal static List<Task> Storage { get; set; } = new List<Task>();

    public string Title { get; set; }
    public Guid Id { get; set; } = Guid.NewGuid();

    public Task(string title = "")
    {
        this.Title = title;
        Task.Storage.Add(this);
    }

    internal static Task Get(Guid guid)
    {
        return Task.Storage.FirstOrDefault(t => t.Id == guid);
    }
}