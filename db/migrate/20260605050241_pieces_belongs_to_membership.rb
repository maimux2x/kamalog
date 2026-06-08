class PiecesBelongsToMembership < ActiveRecord::Migration[8.1]
  def change
    add_reference :pieces, :membership, foreign_key: true

    reversible do |dir|
      dir.up do
        execute <<~SQL
          UPDATE pieces SET membership_id = 1;
        SQL
      end
    end

    change_column_null :pieces, :membership_id, false

    remove_reference :pieces, :user, foreign_key: true, null: false
  end
end
