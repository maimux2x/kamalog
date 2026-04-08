class CreateUsers < ActiveRecord::Migration[8.1]
  def change
    create_table :users do |t|
      t.string :uid,  null: false
      t.string :name, null: false

      t.timestamps

      t.index :uid, unique: true
    end
  end
end
