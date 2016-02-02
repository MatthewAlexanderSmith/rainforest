class RemoveTagFromCategories < ActiveRecord::Migration
  def change
    remove_column :categories, :tag, :string
  end
end
