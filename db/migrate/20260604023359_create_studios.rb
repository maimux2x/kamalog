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

    reversible do |dir|
      dir.up do
        execute <<~SQL
          INSERT INTO studios VALUES (1, '陶芸教室 Cactus', NOW(), NOW());

          UPDATE clays SET studio_id = 1;

          UPDATE glazes SET studio_id = 1;
        SQL

        change_column_null :clays,  :studio_id, false
        change_column_null :glazes, :studio_id, false
      end
    end
  end
end
