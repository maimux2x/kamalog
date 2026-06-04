class HomesController < ApplicationController
  def show
    @studio = current_user.memberships.first.studio
  end
end
