class AddProjectIdToCategories < ActiveRecord::Migration[6.1]
  def change
    add_column :categories, :project_id, :integer 
  end
end
