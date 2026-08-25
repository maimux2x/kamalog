class AddCompletedAtToPieces < ActiveRecord::Migration[8.1]
  def change
    add_column :pieces, :completed_at, :datetime

    reversible do |dir|
      dir.up do
        execute <<~SQL
          UPDATE pieces
          SET completed_at = updated_at
          WHERE status = 1;
        SQL
      end
    end
  end
end
