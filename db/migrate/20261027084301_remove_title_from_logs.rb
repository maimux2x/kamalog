class RemoveTitleFromLogs < ActiveRecord::Migration[8.1]
  def change
    remove_column :logs, :title
  end
end
