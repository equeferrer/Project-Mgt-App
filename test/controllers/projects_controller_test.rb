require "test_helper"

class ProjectsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @project = Project.create(name: 'New Project')
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
    assert_redirected_to projects_path
  end

  test "05. should delete project" do
    assert_difference('Project.count', -1) do
      delete project_path @project
    end
    # Redirect
  end
end
