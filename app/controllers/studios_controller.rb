class StudiosController < ApplicationController
  include CurrentMembership

  def index
    if current_user.studios.size == 1
      redirect_to studio_path(current_user.studios.first)
    else
      @studios = current_user.studios.order(:id)
    end
  end

  def show
    @studio = current_studio
  end

  private

  def studio_id_params
    params[:id]
  end
end
