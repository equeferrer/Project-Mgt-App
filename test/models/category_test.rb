require "test_helper"

class CategoryTest < ActiveSupport::TestCase
  def setup
    @project = Project.create(name: 'Project 1')
    @category = Category.create(title: 'Category 1', project_id: @project.id)
  end
  
  test "1. should not save Category without title" do
    category = Category.new
    assert_not category.save, 'Saved category without title'
  end

  test "01a. should not save when category is not assigned to project" do
    @category.project_id = ''
    assert_not @category.save,  'Saved task without category'
  end
end
