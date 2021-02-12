# require "test_helper"

# class CreateCategoryTest < ActionDispatch::IntegrationTest
#   test "should go to new category form and create task" do
#     # go to new user path 
#     get new_category_path
#     assert_response :success
   
#     # submit form
#     assert_difference 'Category.count', 1 do
#       post create_category_path, params: {category: {title: 'Category Test'} }
#       assert_response :redirect 
#     end

#    #after submit
#    follow_redirect!
#    assert_response :success
#  end
# end