class AddUniqueIndexToGlazeUsages < ActiveRecord::Migration[8.1]
  def change
    add_index :glaze_usages, [:piece_id, :glaze_id], unique: true
  end
end
