class AddUniqueIndexToGlazes < ActiveRecord::Migration[8.1]
  def change
    add_index :glazes, [:studio_id, :name], unique: true
    remove_index :glazes, :name, uniqur: true
  end
end
