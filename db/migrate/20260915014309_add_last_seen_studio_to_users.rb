class AddLastSeenStudioToUsers < ActiveRecord::Migration[8.1]
  def change
    add_reference :users, :last_seen_studio, foreign_key: {to_table: :studios}
  end
end
