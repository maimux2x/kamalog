class AddNullFalseToGlazesAndClays < ActiveRecord::Migration[8.1]
  def change
    change_column_null :clays,  :studio_id, false
    change_column_null :glazes, :studio_id, false
  end
end
