class StudiosController < ApplicationController
  def index
    redirect_to studio_path(current_user.studios.first), status: :see_other
  end

  def show
    @studio = current_user.studios.first
  end
end
