require "test_helper"

class ProjectsControllerTest < ActionDispatch::IntegrationTest
  def setup
    get '/users/sign_in'
    sign_in users(:user_001)
    post user_session_url

    @project = Project.create(name: 'New Project', user_id: 1)
    @project.save
  end

  test "01. should get index" do
    get projects_path
    assert_response :success
  end

  test "02. should get new, create project, then redirect" do
    get new_project_path
    assert_response :success

    assert_difference('Project.count', 1) do
      post projects_path(@project),
      params: { project: { name: 'Project 1' } } 
      assert_response :redirect
    end
  end

  test "03. should get edit" do
    get edit_project_path(@project)
    assert_response :success
  end

  test "04. should be able to update project name, redirects after" do
    patch project_path(@project), params: {
      project: { name: 'New Name' }
    }
    assert_redirected_to project_path(@project)
  end

  test "05. should delete project" do
    assert_difference('Project.count', -1) do
      delete project_path @project
    end
    assert_redirected_to projects_path
  end

  test "06. should not get new if not logged in" do
    sign_out :user
    get new_project_path
    assert_redirected_to new_user_session_path
  end

  test "07. should show project" do
    get projects_path @project
    assert_response :success
  end
end
