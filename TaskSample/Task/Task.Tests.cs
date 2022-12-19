namespace TaskSample.Task;

public class Tests
{
    [Test]
    public void Create_Empty()
    {
        Task task = new Task();

        Assert.IsTrue(task != null);
    }

    [Test]
    public void Create_WithTitle()
    {
        string expectedTitle = "My Task Title";

        Task task = new Task(expectedTitle);
        Assert.That(task.Title, Is.EqualTo(expectedTitle));
    }
}
