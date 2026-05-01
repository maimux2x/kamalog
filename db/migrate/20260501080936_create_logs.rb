class CreateLogs < ActiveRecord::Migration[8.1]
  def change
    create_table :logs do |t|
      t.references :piece, foreign_key: true, null: false

      t.string   :title,     null: false
      t.datetime :timestamp, null: false
      t.string   :body

      t.timestamps
    end

    create_table :photos do |t|
      t.references :log, foreign_key: true, null: false

      t.timestamps
    end
  end
end
