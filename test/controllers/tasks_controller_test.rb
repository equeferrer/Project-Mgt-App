require "test_helper"

class TasksControllerTest < ActionDispatch::IntegrationTest
  def setup
    get '/users/sign_in'
    sign_in users(:user_001)
    post user_session_url
    @project = Project.create(name: 'Project 1', user_id: 1)
    @category = Category.create(title: 'Category 1', project_id: @project.id, user_id: 1)
    @task = @category.tasks.create(name: "First Task!", priority_level: "1", category_id: @category.id, user_id: 1, project_id: @category.project_id)
    
    @project.save
    @category.save
    @task.save
  end

  # test "01. should get index of tasks" do
  #   get category_tasks_path @category
  #   assert_response :success
  # end

  test "02. should get new action of tasks" do
    get new_category_task_path @category
    assert_response :success
  end

  test "03. should get new, create task, then redirect" do
    get new_category_task_path @category
    assert_response :success

    assert_difference('Task.count', 1) do
      post category_tasks_path @category, params: { 
        task: { name: "First Task!", priority_level: "1", user_id: 1, project_id:@category.project_id } } 
      assert_response :redirect
    end
  end

  test "04. should get edit" do
    get edit_task_path @task
    assert_response :success
  end

  test "05. should be able to update category title, description, duedate, priority level" do
    patch task_path @task,
    params: { task: { name: 'Edited Task', priority_level: "2", due_date: "2021-02-12" } }
    assert_redirected_to project_path(@task.project_id)
  end

  test "06. should delete category" do
    assert_difference('Task.count', -1) do
      delete task_path @task
    end
    assert_redirected_to project_path(@task.project_id)
  end
end
