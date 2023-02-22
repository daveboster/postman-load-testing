namespace TaskSample.Task;

public class Tests
{
    [Test]
    public void Create_WithTitle()
    {
        string expectedTitle = "My Task Title";

        Task task = new Task(expectedTitle);
        Assert.That(task.Title, Is.EqualTo(expectedTitle));
    }

    [Test]
    public void Create_Returns_TimecardIdentifier()
    {
        Task task = new Task();
        Assert.That(task.Id, Is.Not.EqualTo(Guid.Empty));
    }
}
