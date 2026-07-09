class AddPositionToClays < ActiveRecord::Migration[8.1]
  def change
    reversible do |dir|
      dir.up do
        add_column :clays, :position, :integer

        execute <<~SQL
          UPDATE clays
          SET position = position_num
          FROM (
            SELECT id, ROW_NUMBER() OVER(ORDER BY id) AS position_num
            FROM clays
          ) c
          WHERE clays.id = c.id
        SQL

        change_column_null :clays, :position, false
        add_index :clays, :position, unique: true
      end

      dir.down do
        remove_column :clays, :position, :integer, null: false, unique: true
      end
    end
  end
end
