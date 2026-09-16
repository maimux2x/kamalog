class WelcomesController < ApplicationController
  def show
    if studio = current_user.last_seen_studio || current_user.studios.first
      redirect_to studio_my_pieces_path(studio), status: :see_other
    end
  end
end
