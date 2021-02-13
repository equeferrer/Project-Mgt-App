require "test_helper"

class ProjectTest < ActiveSupport::TestCase
  test "1. should not save Project without name" do
    project = Project.new
    assert_not project.save, 'Saved project without name'
  end
end
