require "test_helper"

class CategoriesControllerTest < ActionDispatch::IntegrationTest

  def setup
    @category = Category.create(title: 'Category 1')
  end

  test "1a. should get index" do
    get categories_path
    assert_response :success
  end

  test "1b. should get new" do
    get new_category_path
    assert_response :success
  end

  test "1c. should create category" do
    post create_category_path, params: { category: { 
      title: 'Category 1',
    } } 
  end

  test "1d. should get edit" do
    get category_edit_path(@category)
    assert_response :success
  end

  test "1e. should be able to edit category title" do
    patch category_update_path(@category), params: {
      category: { title: 'New Title' }
    }
    
    assert Category.find(@category.id).title == 'New Title' 
    # assert_redirected_to root_path
  end

  test "1f. should delete category" do
    assert_difference('Category.count', -1) do
      delete category_delete_path @category
    end
  end
end
