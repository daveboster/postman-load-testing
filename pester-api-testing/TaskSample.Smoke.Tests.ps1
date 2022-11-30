Describe 'Creating Tasks' {

    It 'It should create a task given a title' {

        $expectedTitle = "Test";

        $createdTask = Add-ApiResource "tasks/create?title=$($expectedTitle)"

        $createdTask.title | Should -Be $expectedTitle
    }

}