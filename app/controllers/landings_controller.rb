class LandingsController < ApplicationController
  layout 'blank'

  skip_before_action :require_authentication, only: %i[show]

  def show
    redirect_to welcome_path, status: :see_other if authenticated?
  end
end
