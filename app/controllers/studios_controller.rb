class StudiosController < ApplicationController
  def index
    redirect_to studio_path(current_studio), status: :see_other
  end

  def show
    @studio = current_studio
  end
end
