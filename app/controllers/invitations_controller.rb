class InvitationsController < ApplicationController
  def show
    @studio = Studio.where(invitation_enabled: true).find_by!(token: params[:token])
  end

  def accept
    studio = Studio.where(invitation_enabled: true).find_by!(token: params[:invitation_token])

    current_user.memberships.create! studio: studio

    redirect_to studio_path(studio), status: :see_other, notice: "#{studio.name}に参加しました。"
  end
end
