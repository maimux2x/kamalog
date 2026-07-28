class AddPositionToGlazes < ActiveRecord::Migration[8.1]
  def up
    add_column :glazes, :position, :integer

    execute <<~SQL
      UPDATE glazes
      SET position = position_num
      FROM (
        SELECT id, ROW_NUMBER() OVER(PARTITION BY studio_id ORDER BY id) AS position_num
        FROM glazes
      ) g
      WHERE glazes.id = g.id;
    SQL

    change_column_null :glazes, :position, false
    add_index :glazes, [:studio_id, :position], unique: true
  end

  def down
    remove_index :glazes, [:studio_id, :position], unique: true
    remove_column :glazes, :position
  end
end
