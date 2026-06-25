class InvitationsController < ApplicationController
  def show
    @studio = Studio.where.not(invitation_token: nil).find_by!(invitation_token: params[:token])
  end

  def accept
    studio = Studio.where.not(invitation_token: nil).find_by!(invitation_token: params[:invitation_token])

    current_user.memberships.create! studio: studio

    redirect_to studio_path(studio), status: :see_other, notice: "#{studio.name}に参加しました。"
  end
end
