class ChangeWeightType < ActiveRecord::Migration[8.1]
  def change
    reversible do |dir|
      dir.up do
        change_column :clay_usages, :weight, :float, null: false
      end

      dir.down do
        change_column :clay_usages, :weight, :integer, null: false
      end
    end
  end
end
