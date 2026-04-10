class CreatePieces < ActiveRecord::Migration[8.1]
  def change
    create_table :pieces do |t|
      t.references :user, foreign_key: true, null: false

      t.string  :title,       null: false
      t.integer :status,      null: false, default: 0
      t.integer :form_method, null: false

      t.timestamps
    end
  end
end
