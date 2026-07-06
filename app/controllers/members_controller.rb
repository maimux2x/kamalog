class MembersController < ApplicationController
  include CurrentMembership

  before_action :last_admin_cannot_leave, only: %i[update destroy]

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

  def last_admin_cannot_leave
    if current_studio.memberships.find(params[:id]).user == current_user && current_studio.sole_admin?
      redirect_to studio_members_path(current_studio), status: :see_other, alert: '管理者は最低一人必要です。'
    end
  end
end
