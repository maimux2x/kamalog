class AddRoleToMemberships < ActiveRecord::Migration[8.1]
  def up
    add_column :memberships, :role, :integer, null: false, default: 0

    execute <<~SQL
      UPDATE memberships
      SET role = 1
      WHERE id IN (
        SELECT MIN(id)
        FROM memberships
        GROUP BY studio_id
      );
    SQL
  end

  def down
    remove_column :memberships, :role, :integer, null: false, default: 0
  end
end
