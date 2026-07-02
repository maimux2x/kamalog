class MembersController < ApplicationController
  include CurrentMembership

  def index
    @pagy, @memberships = pagy(:offset, current_studio.memberships.includes(:user).order(:id))
  end

  def update
    current_studio.memberships.find(params[:id]).update! membership_params

    redirect_to studio_members_path(current_studio), status: :see_other, notice: 'メンバーの役割を更新しました。'
  end

  def destroy
    current_studio.memberships.find(params[:id]).destroy!

    redirect_to studio_members_path(current_studio), status: :see_other, notice: 'メンバーを削除しました。'
  end

  private

  def membership_params
    params.expect(membership: [
      :role
    ])
  end
end
