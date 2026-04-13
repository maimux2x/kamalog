class CreateClaysGlazes < ActiveRecord::Migration[8.1]
  def change
    create_table :clays do |t|
      t.string :name, null: false

      t.timestamps
    end

    create_table :glazes do |t|
      t.string :name, null: false

      t.timestamps
    end

    create_table :clay_usages do |t|
      t.references :piece, foreign_key: true, null: false
      t.references :clay,  foreign_key: true, null: false

      t.integer :weight, null: false

      t.timestamps
    end

    create_table :glaze_usages do |t|
      t.references :piece, foreign_key: true, null: false
      t.references :glaze, foreign_key: true, null: false

      t.timestamps
    end
  end
end
