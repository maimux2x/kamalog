class Studios::InvitationsController < ApplicationController
  include CurrentMembership

  def create
    current_studio.update! invitation_token: SecureRandom.base58(24)

    redirect_to studio_members_path(current_studio), status: :see_other, notice: 'メンバーの招待を有効にしました。'
  end

  def destroy
    current_studio.update! invitation_token: nil

    redirect_to studio_members_path(current_studio), status: :see_other, notice: 'メンバーの招待を無効にしました。'
  end
end
