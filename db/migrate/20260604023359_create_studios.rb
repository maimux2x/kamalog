class CreateStudios < ActiveRecord::Migration[8.1]
  def change
    create_table :studios do |t|
      t.string :name, null: false

      t.timestamps
    end

    create_table :memberships do |t|
      t.references :user,   foreign_key: true, null: false
      t.references :studio, foreign_key: true, null: false
    end

    add_reference :clays,  :studio, foreign_key: true
    add_reference :glazes, :studio, foreign_key: true
  end
end
