class DropPiecePhotos < ActiveRecord::Migration[8.1]
  def change
    drop_table :piece_photos do |t|
      t.string     'caption'
      t.datetime   'created_at', null: false
      t.references 'piece',      null: false, foreign_key: true
      t.integer    'position',   null: false
      t.datetime   'updated_at', null: false

      t.index ['piece_id', 'position'], name: 'index_piece_photos_on_piece_id_and_position', unique: true
    end
  end
end
