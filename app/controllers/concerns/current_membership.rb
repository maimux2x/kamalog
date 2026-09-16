module CurrentMembership
  extend ActiveSupport::Concern

  included do
    helper_method :current_membership, :current_studio
  end

  private

  def current_membership
    return nil unless studio_id_param

    @current_membership ||= current_user.memberships.find_by!(studio_id: studio_id_param)
  end

  def current_studio
    current_membership&.studio
  end

  def studio_id_param
    params[:studio_id]
  end
end
