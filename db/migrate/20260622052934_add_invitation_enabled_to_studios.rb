class AddInvitationEnabledToStudios < ActiveRecord::Migration[8.1]
  def change
    add_column :studios, :invitation_enabled, :boolean, null: false, default: false
  end
end
