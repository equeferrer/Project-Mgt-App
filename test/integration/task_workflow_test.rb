require "test_helper"

class CreateTaskTest < ActionDispatch::IntegrationTest
  
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

  test "01. should go to new task form and create a new task" do
    get new_category_task_path @category
    assert_response :success

    assert_difference "Task.count", 1 do
      post category_tasks_path @category, params: {
         task: { name: "Second Task!", priority_level: "3", category_id: @category.id, user_id: 1, project_id: @category.project_id } }
      assert_response :redirect
    end

    follow_redirect!
    assert_response :success
  end

  test '02. should update current task' do
    get edit_task_path(@task)
    assert_response :success
    
    assert_changes '@task.name' do
      patch task_path @task,
      # params: { task: { name: 'Edited Task' } }
      # byebug
      params: { task: { name: 'Edited Task', priority_level: "2", due_date: "2021-02-12" } }
      @task.reload
      assert_response :redirect
    end
    
    follow_redirect!
    assert_response :success
  end

  test '03. delete task' do
    assert_difference 'Task.count', -1 do
      delete task_path @task
      assert_response :redirect
    end

    follow_redirect!
    assert_response :success
  end

end