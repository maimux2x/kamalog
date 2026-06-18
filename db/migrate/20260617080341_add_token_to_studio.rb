class AddTokenToStudio < ActiveRecord::Migration[8.1]
  def change
    add_column :studios, :token, :string, null: false
  end
end
