class AddDescriptionToPieces < ActiveRecord::Migration[8.1]
  def change
    add_column :pieces, :description, :string
  end
end
