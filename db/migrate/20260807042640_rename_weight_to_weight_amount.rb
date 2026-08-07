class RenameWeightToWeightAmount < ActiveRecord::Migration[8.1]
  def change
    rename_column :clay_usages, :weight, :weight_amount
  end
end
