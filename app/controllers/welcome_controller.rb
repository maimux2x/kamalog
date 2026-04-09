class WelcomeController < ApplicationController
  skip_before_action :require_authentication, only: %i[index]

  def index; end
end
