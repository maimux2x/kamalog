class StudiosController < ApplicationController
  include CurrentMembership

  def index
    @studios = current_user.studios.order(:id).to_a

    if @studios.size == 1
      redirect_to studio_path(@studios.first)
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
