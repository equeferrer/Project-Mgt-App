require "test_helper"

class CategoryTest < ActiveSupport::TestCase
  test "1. should not save Category without title" do
    category = Category.new
    assert_not category.save, 'Saved category without title'
  end
end
