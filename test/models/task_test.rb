require "test_helper"

class TaskTest < ActiveSupport::TestCase
  def setup
    @project = Project.create(name: 'Project 1')
    @category = Category.create(title: 'Category 1', project_id: @project.id)
    @task = Task.create(name: "Task", description: "Testing Nested Resources", 
                        priority_level: "1", due_date: "2021-02-15", category_id: @category.id)                   
  end

  test "01a. should not save when task is not assigned to category" do
    @task.category_id = ''
    assert_not @task.save,  'Saved task without category'
    # @category.tasks.create(name: "First Task!", description: "Testing Nested Resources", priority_level: "1")
  end

  test "02. should not save task without name" do
    @task.name = ""
    assert_not @task.save, 'Saved task without name'
  end

  test "03. should not save task without priority level" do
    @task.priority_level = ""
    assert_not @task.save, 'Saved task without priority level'
  end

  test "04. should not save task with priority level that is not a number" do
    @task.priority_level = "a1"
    assert_not @task.save, 'Saved task with priority level that isNaN'
  end

  test "05. should not save task with priority level that is below 0" do
    @task.priority_level = "-1"
    assert_not @task.save, 'Saved task with priority level that is below 0'
  end

  test "06. should not save task with priority level that is greater than 4" do
    @task.priority_level = "5"
    assert_not @task.save, 'Saved task with priority level that is greater than 4'
  end

end