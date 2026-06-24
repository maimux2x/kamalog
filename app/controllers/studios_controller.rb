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

  def edit
    @studio = current_studio
  end

  def update
    current_studio.update!(studio_params)

    redirect_to edit_studio_path(current_studio), status: :see_other, notice: 'スタジオを更新しました。'
  end

  private

  def studio_id_params
    params[:id]
  end

  def studio_params
    params.expect(studio: [
      :name
    ])
  end
end
