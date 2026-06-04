class WelcomeController < ApplicationController
  skip_before_action :require_authentication, only: %i[index]

  def index
    redirect_to studio_path(curent_user.studios.first), status: :see_other if authenticated?
  end
end
