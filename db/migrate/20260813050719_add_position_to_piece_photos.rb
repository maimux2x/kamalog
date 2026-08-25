class AddPositionToPiecePhotos < ActiveRecord::Migration[8.1]
  def change
    add_column :piece_photos, :position, :integer

    reversible do |dir|
      dir.up do
        execute <<~SQL
          UPDATE piece_photos AS pp
          SET position = tmp.position
          FROM (
            SELECT id, ROW_NUMBER() OVER(PARTITION BY piece_id ORDER BY id) AS position
            FROM piece_photos
          ) AS tmp
          WHERE pp.id = tmp.id;
        SQL
      end
    end

    change_column_null :piece_photos, :position, false
    add_index :piece_photos, [:piece_id, :position], unique: true
  end
end
