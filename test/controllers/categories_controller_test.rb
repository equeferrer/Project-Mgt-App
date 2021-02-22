require "test_helper"

class CategoriesControllerTest < ActionDispatch::IntegrationTest

  def setup
    get '/users/sign_in'
    sign_in users(:user_001)
    post user_session_url

    @project = Project.create(name: 'New Project', user_id: 1)
    @category = Category.create(title: 'Category 1', project_id: @project.id, user_id: 1)

    @project.save
    @category.save
  end

  # test "01. should get index" do
  #   get project_categories_path @project
  #   assert_response :success
  # end

  test "02. should get new, create category, then redirect" do
    get new_project_category_path @project
    assert_response :success

    assert_difference('@project.categories.count', 1) do
      post project_categories_path @project,
      params: { category: { title: 'Category 2', user_id: 1 } } 
      assert_response :redirect
    end
  end

  test "03. should get edit" do
    get edit_category_path @category
    assert_response :success
  end

  test "04. should be able to update category title, redirects after" do
    patch category_path @category, params: { category: { title: 'New Title' } }
    # assert Category.find(@category.id).title == 'New Title' 
    assert_redirected_to project_path(@category.project_id)
  end

  test "05. should delete category" do
    assert_difference('Category.count', -1) do
      delete category_path @category
    end
    assert_redirected_to project_path @project
  end

  test "06. should not get new if not logged in" do
    sign_out :user
    get new_project_category_path @project
    assert_redirected_to new_user_session_path
  end
end
