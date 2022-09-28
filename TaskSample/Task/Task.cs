namespace TaskSample.Task;
public class Task 
{
    public string Title { get; set; }

    public Task(string title = "")
    {
        this.Title = title;
    }
}