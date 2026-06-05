class PiecesBelongsToStudio < ActiveRecord::Migration[8.1]
  def change
    add_reference :pieces, :studio, foreign_key: true

    reversible do |dir|
      dir.up do
        execute <<~SQL
          UPDATE pieces SET studio_id = 1;
        SQL
      end
    end

    change_column_null :pieces, :studio_id, false
  end
end
