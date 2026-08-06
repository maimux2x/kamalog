class AddWeightUnitToClayUsages < ActiveRecord::Migration[8.1]
  def up
    add_column :clay_usages, :weight_unit, :integer

    execute <<~SQL
      UPDATE clay_usages
      SET weight_unit = 0
    SQL

    change_column_null :clay_usages, :weight_unit, false
  end

  def down
    remove_column :clay_usages, :weight_unit
  end
end
