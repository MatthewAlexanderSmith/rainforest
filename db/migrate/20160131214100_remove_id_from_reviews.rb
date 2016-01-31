class RemoveIdFromReviews < ActiveRecord::Migration
  def change
    remove_column :reviews, :users_id, :integer
  end
end
