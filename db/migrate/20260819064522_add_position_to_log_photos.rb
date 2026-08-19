class AddPositionToLogPhotos < ActiveRecord::Migration[8.1]
  def change
    reversible do |dir|
      dir.up do
        add_column :log_photos, :position, :integer

        execute <<~SQL
          UPDATE log_photos
          SET position = tmp.num
          FROM (
            SELECT id, ROW_NUMBER() OVER (PARTITION BY log_id ORDER BY id) AS num
            FROM log_photos
          ) AS tmp
          WHERE log_photos.id = tmp.id;
        SQL

        change_column_null :log_photos, :position, false
        add_index :log_photos, [:log_id, :position], unique: true
      end

      dir.down do
        remove_column :log_photos, :position
      end
    end
  end
end
