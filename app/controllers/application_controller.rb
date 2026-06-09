class ApplicationController < ActionController::Base
  before_action :require_authentication

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  private

  def require_authentication
    redirect_to root_path unless authenticated?
  end

  def current_user
    return @current_user if defined?(@current_user)

    @current_user = (id = session[:current_user_id]) ? User.find_by(id:) : nil
  end

  def current_membership
    current_user.memberships.find_by!(studio_id: params[:studio_id] || params[:id])
  end

  def current_studio
    current_membership.studio
  end

  def authenticated?
    !!current_user
  end

  helper_method :current_user, :current_studio, :authenticated?
end
