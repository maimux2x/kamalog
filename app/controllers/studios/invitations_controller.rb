class Studios::InvitationsController < ApplicationController
  include CurrentMembership

  def create
    ActiveRecord::Base.transaction do
      current_studio.regenerate_token
      current_studio.update! invitation_enabled: true
    end

    redirect_to studio_members_path(current_studio), status: :see_other, notice: 'メンバーの招待を有効にしました。'
  end

  def destroy
    current_studio.update! invitation_enabled: false

    redirect_to studio_members_path(current_studio), status: :see_other, notice: 'メンバーの招待を無効にしました。'
  end
end
