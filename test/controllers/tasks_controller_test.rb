require "test_helper"

class TasksControllerTest < ActionDispatch::IntegrationTest
  def setup
    @category = Category.create(title: 'Category 1')
    @task = @category.tasks.create(name: "First Task!", description: "Testing Nested Resources", priority_level: "1")
    
    @category.save
    @task.save
  end

  test "01. should get index of tasks" do
    get category_tasks_path @category
    assert_response :success
  end

  test "02. should get new action of tasks" do
    get new_category_task_path @category
    assert_response :success
  end

  test "03. should get new, create task, then redirect" do
    get new_category_task_path @category
    assert_response :success

    assert_difference('Task.count', 1) do
      post category_tasks_path @category, params: { 
        task: { name: "First Task!", description: "Testing Nested Resources", priority_level: "1" } } 
      # assert_response :redirect
    end
  end

  test "04. should get edit" do
    get edit_category_task_path @category, @task
    assert_response :success
  end

  test "04. should be able to update category title, description, duedate, priority level" do
    patch category_task_path @category,@task,
    params: {
      task: { name: 'Edited Task', description: "Edited Description", priority_level: "2", due_date: "2021-02-12" }
    }
    assert_redirected_to category_tasks_path
  end

  test "05. should delete category" do
    assert_difference('Task.count', -1) do
      delete category_task_path @category,@task
    end
  end
end
