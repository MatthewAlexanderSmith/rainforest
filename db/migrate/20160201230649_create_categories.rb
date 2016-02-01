class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :tag
      t.integer :product_id
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
