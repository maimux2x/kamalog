class AddPositionToClays < ActiveRecord::Migration[8.1]
  def up
    add_column :clays, :position, :integer

    execute <<~SQL
      UPDATE clays
      SET position = position_num
      FROM (
        SELECT id, ROW_NUMBER() OVER(PARTITION BY studio_id ORDER BY id) AS position_num
        FROM clays
      ) c
      WHERE clays.id = c.id
    SQL

    change_column_null :clays, :position, false
    add_index :clays, [:studio_id, :position], unique: true
  end

  def down
    remove_column :clays, :position
  end
end
