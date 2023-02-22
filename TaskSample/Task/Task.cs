namespace TaskSample.Task;
public class Task
{
    public string Title { get; set; }
    public Guid Id { get; set; } = Guid.NewGuid();

    public Task(string title = "")
    {
        this.Title = title;
    }
}