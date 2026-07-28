class AddUniqueIndexToClays < ActiveRecord::Migration[8.1]
  def change
    add_index :clays, [:studio_id, :name], unique: true
    remove_index :clays, :name, unique: true
  end
end
