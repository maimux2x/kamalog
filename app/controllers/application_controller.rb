class ApplicationController < ActionController::Base
  before_action :require_authentication

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  private

  def require_authentication
    redirect_to root_path unless current_user
  end

  def current_user
    @current_user ||= User.find_by(id: session[:current_user_id]) if session[:current_user_id]
  end

  def authenticated?
    !!current_user
  end

  helper_method :current_user, :authenticated?
end
