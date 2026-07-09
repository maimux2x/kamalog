class MembersController < ApplicationController
  include CurrentMembership

  before_action :require_self_or_admin,   only: %i[destroy]
  before_action :require_admin,           only: %i[update]
  before_action :last_admin_cannot_leave, only: %i[update destroy]

  def index
    @pagy, @memberships = pagy(:offset, current_studio.memberships.includes(:user).order(:created_at))
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

  def require_self_or_admin
    return if current_membership.admin?

    membership = current_studio.memberships.find(params[:id])

    return if membership == current_membership

    redirect_to studio_members_path(current_studio), status: :see_other, alert: '権限がありません。'
  end

  def require_admin
    return if current_membership.admin?

    redirect_to studio_members_path(current_studio), status: :see_other, alert: '権限がありません。'
  end

  def last_admin_cannot_leave
    user = current_studio.memberships.find(params[:id]).user

    return unless current_studio.last_admin?(user)

    redirect_to studio_members_path(current_studio), status: :see_other, alert: '管理者は最低一人必要です。'
  end
end
