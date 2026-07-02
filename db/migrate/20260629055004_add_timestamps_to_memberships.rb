class AddTimestampsToMemberships < ActiveRecord::Migration[8.1]
  def change
    add_column :memberships, :created_at, :datetime
    add_column :memberships, :updated_at, :datetime

    reversible do |dir|
      dir.up do
        execute <<~SQL
          UPDATE memberships
          SET created_at = DATETIME('now'),
              updated_at = DATETIME('now');
        SQL
      end
    end

    change_column_null :memberships, :created_at, false
    change_column_null :memberships, :updated_at, false
  end
end
