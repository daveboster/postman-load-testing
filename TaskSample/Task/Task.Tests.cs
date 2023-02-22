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

    [Test]
    public void Given_TaskId_That_DoesNotExist_When_Getting_Task_Then_Returns_Null()
    {
        Task task = Task.Get(Guid.NewGuid());
        Assert.That(task, Is.Null);
    }

    [Test]
    public void Creating_Task_Get_Task_WithSameIdReturnsTaskWithMatchingTitle()
    {
        string expectedTitle = "My Task Title";

        Task task = new Task(expectedTitle);
        Task task2 = Task.Get(task.Id);

        Assert.That(task2.Title, Is.EqualTo(expectedTitle));
    }
}
