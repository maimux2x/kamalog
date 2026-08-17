class AddPositionToPiecePhotos < ActiveRecord::Migration[8.1]
  def change
    reversible do |dir|
      dir.up do
        add_column :piece_photos, :position, :integer

        execute <<~SQL
          UPDATE piece_photos AS pp
          SET position = tmp.position
          FROM (
            SELECT id, ROW_NUMBER() OVER(PARTITION BY piece_id ORDER BY id) AS position
            FROM piece_photos
          ) AS tmp
          WHERE pp.id = tmp.id;
        SQL

        change_column_null :piece_photos, :position, false
        add_index :piece_photos, [:piece_id, :position], unique: true
      end

      dir.down do
        remove_column :piece_photos, :position
      end
    end
  end
end
