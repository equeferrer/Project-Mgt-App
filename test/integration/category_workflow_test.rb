  require "test_helper"

  class CreateCategoryTest < ActionDispatch::IntegrationTest

    def setup
      get '/users/sign_in'
      sign_in users(:user_001)
      post user_session_url
  
      @project = Project.create(name: 'New Project', user_id: 1)
      @category = Category.create(title: 'Category 1', project_id: @project.id, user_id: 1)

      @project.save
      @category.save
    end

    test "01. should go to new category form and create category" do
      get new_project_category_path @project
      assert_response :success
    
      assert_difference 'Category.count', 1 do
        post project_categories_path @project, params: {category: {title: 'Category 2', project_id: @project.id, user_id: 1} }
        assert_response :redirect 
      end

     follow_redirect!
     assert_response :success
   end

   test '02. should update category' do
    get edit_category_path(@category)
    assert_response :success
    
    assert_changes '@category.title' do
      patch category_path(@category), params: {category: {title: 'Edited Category'}}
      @category.reload
      assert_response :redirect
    end
    
    follow_redirect!
    assert_response :success
  end

  test '03. delete a current category' do
    assert_difference 'Category.count', -1 do
    delete category_path(@category)
      assert_response :redirect
    end
    
    follow_redirect!
    assert_response :success
  end

  end