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
        string t = "My Task Title";

        Task task = new Task(t);
  
        Assert.AreEqual(task.Title, t);
    }
}
