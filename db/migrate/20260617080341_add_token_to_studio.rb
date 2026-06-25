class AddTokenToStudio < ActiveRecord::Migration[8.1]
  def change
    add_column :studios, :invitation_token, :string

    add_index :studios, :invitation_token, unique: true
  end
end
