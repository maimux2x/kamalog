class AddUniqueIndexToClaysAndGlazes < ActiveRecord::Migration[8.1]
  def change
    add_index :clays,  :name, unique: true
    add_index :glazes, :name, unique: true
  end
end
