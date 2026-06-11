module CurrentMembership
  extend ActiveSupport::Concern

  included do
    helper_method :current_membership, :current_studio
  end

  private

  def current_membership
    @current_membership ||= current_user.memberships.find_by!(studio_id: studio_id_params)
  end

  def current_studio
    current_membership.studio
  end

  def studio_id_params
    params[:studio_id]
  end
end
