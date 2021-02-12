require "test_helper"

class CategoriesControllerTest < ActionDispatch::IntegrationTest

  def setup
    @category = Category.create(title: 'Category 1')
  end

  test "01. should get index" do
    get categories_path
    assert_response :success
  end

  test "02. should get new, create category, then redirect" do
    get new_category_path
    assert_response :success

    assert_difference('Category.count', 1) do
      post categories_path(@category),
      params: { category: { title: 'Category 1' } } 
      assert_response :redirect
    end
  end

  test "03. should get edit" do
    get edit_category_path(@category)
    assert_response :success
  end

  test "04. should be able to update category title, redirects after" do
    patch category_path(@category), params: {
      category: { title: 'New Title' }
    }
    
    # assert Category.find(@category.id).title == 'New Title' 
    assert_redirected_to categories_path
  end

  test "05. should delete category" do
    assert_difference('Category.count', -1) do
      delete category_path @category
    end
  end
end
