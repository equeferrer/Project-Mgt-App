require "test_helper"

class HomeControllerTest < ActionDispatch::IntegrationTest
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

  test "1. should get index" do
    get home_index_url
    assert_response :success
  end

  test "2. should have a link to show projects" do
    get home_index_url
    assert_select "a:match('href', ?)", projects_path
  end

  test "3. should not show link to projects if not logged in" do
    sign_out :user
    assert_select "a:match('href', ?)", projects_path, false #can use count here also
  end

  test "4. should not be able to get projects if not logged in" do
    sign_out :user
    get projects_path
    assert_redirected_to new_user_session_path
  end

  test "5. should have a link to create new project" do
    get home_index_url
    assert_select "a:match('href', ?)", new_project_path 
  end

  test "6 should only show current user's projects" do
    @user_two_project = Project.create(name: 'Project 2', user_id: 2)
    current_user_projects = Project.where(user_id: 1)
    assert Project.all.length > current_user_projects.length
  end

  
  test "7. should only show max 3 projects" do
    @second_project = Project.create(name: 'Project 2', user_id: 1)
    @third_project = Project.create(name: 'Project 3', user_id: 1)
    @fourth_project = Project.create(name: 'Project 4', user_id: 1)
    get home_index_url
    assert_select "div.project--column" do
      assert_select "div.hover--only", 3
    end
  end

  test "8. should only show incomplete tasks with due date on/before today" do
    @second_task = Task.create(name: "Second Task!", priority_level: "1", category_id: @category.id, completed: true,
                              user_id: 1, project_id: @category.project_id, due_date: "#{Time.now.year}-#{Time.now.month}-#{Time.now.day-2}")
    @third_task = Task.create(name: "Third Task!", priority_level: "1", category_id: @category.id, 
                              user_id: 1, project_id: @category.project_id, due_date: "#{Time.now.year}-#{Time.now.month}-#{Time.now.day-1}")
    @fourth_task = Task.create(name: "Fourth Task!", priority_level: "1", category_id: @category.id, 
                              user_id: 1, project_id: @category.project_id, due_date: "#{Time.now.year}-#{Time.now.month}-#{Time.now.day+1}")
    get home_index_url
    assert_select "tbody" do
      assert_select "tr", 1
    end
  end 
end
