require "test_helper"

class CreateCategoryTest < ActionDispatch::IntegrationTest

  def setup
    get '/users/sign_in'
    sign_in users(:user_001)
    post user_session_url

    @project = Project.create(name: 'New Project', user_id: 1)
    @project.save
  end

  test "should go to new project form and create project" do
    get new_project_path
    assert_response :success
  
    assert_difference 'Project.count', 1 do
      post projects_path, params: {project: {name: 'New Project 2', user_id: 1} }
      assert_response :redirect 
    end

   follow_redirect!
   assert_response :success
  end

  test '02. should update project' do
    get edit_project_path(@project)
    assert_response :success
    
    assert_changes '@project.name' do
      patch project_path(@project), params: {
        project: { name: 'New Name' }
      }
      @project.reload
      assert_response :redirect
    end
    
    follow_redirect!
    assert_response :success
  end

  test '03. should delete project' do
    assert_difference 'Project.count', -1 do
      delete project_path @project
      assert_response :redirect
    end
    
    follow_redirect!
    assert_response :success
  end

end