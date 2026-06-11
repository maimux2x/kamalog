class ClaysController < ApplicationController
  include CurrentMembership

  def index
    @clays = current_studio.clays.order(:id)
  end

  def new
    @clay = current_studio.clays.new
  end

  def create
    current_studio.clays.create! clay_params

    redirect_to studio_clays_path, status: :see_other, notice: '土を登録しました。'
  end

  def edit
    @clay = current_studio.clays.find(params[:id])
  end

  def update
    current_studio.clays.find(params[:id]).update! clay_params

    redirect_to studio_clays_path(current_studio), status: :see_other, notice: '土を更新しました。'
  end

  def destroy
    current_studio.clays.find(params[:id]).destroy!

    redirect_to studio_clays_path(current_studio), status: :see_other, notice: '土を削除しました。'
  end

  private

  def clay_params
    params.expect(clay: [
      :name
    ])
  end
end
