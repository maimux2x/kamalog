class MembersController < ApplicationController
  include CurrentMembership

  def index
    @members = current_studio.users.order(:id)
  end

  def destroy
    current_studio.memberships.find_by!(user_id: params[:id]).destroy!

    redirect_to studio_members_path(current_studio), status: :see_other, notice: 'メンバーを削除しました。'
  end
end
