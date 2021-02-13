require "test_helper"

class CategoriesControllerTest < ActionDispatch::IntegrationTest

  def setup
    @project = Project.create(name: 'Project 1')
    @category = Category.create(title: 'Category 1', project_id: @project.id)

    @project.save
    @category.save
  end

  test "01. should get index" do
    get project_categories_path @project
    assert_response :success
  end

  test "02. should get new, create category, then redirect" do
    get new_project_category_path @project
    assert_response :success

    assert_difference('Category.count', 1) do
      post project_categories_path @project,
      params: { category: { title: 'Category 2' } } 
      # assert_response :redirect
    end
  end

  test "03. should get edit" do
    get edit_category_path @category
    assert_response :success
  end

  test "04. should be able to update category title, redirects after" do
    patch category_path @category, params: { category: { title: 'New Title' } }
    # assert Category.find(@category.id).title == 'New Title' 
    assert_redirected_to category_path
  end

  test "05. should delete category" do
    assert_difference('Category.count', -1) do
      delete category_path @category
    end
    # REDIRECT
  end
end
