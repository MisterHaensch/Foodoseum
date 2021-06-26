class AddRatingToItems < ActiveRecord::Migration[6.1]
  def change
    add_column :items, :rating, :integer
  end
end
