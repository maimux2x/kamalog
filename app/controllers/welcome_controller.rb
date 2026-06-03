class WelcomeController < ApplicationController
  skip_before_action :require_authentication, only: %i[index]

  def index
    redirect_to home_path, status: :see_other if authenticated?
  end
end
