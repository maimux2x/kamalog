class CreatePiecePhotos < ActiveRecord::Migration[8.1]
  def change
    rename_table :photos, :log_photos

    create_table :piece_photos do |t|
      t.references :piece, null: false, foreign_key: true

      t.string :caption

      t.timestamps
    end
  end
end
