class GlazesController < ApplicationController
  include CurrentMembership

  def index
    @glazes = current_studio.glazes.order(:id)
  end

  def new
    @glaze = current_studio.glazes.new
  end

  def create
    current_studio.glazes.create! glaze_params

    redirect_to studio_glazes_path(current_studio), status: :see_other, notice: '釉薬を登録しました。'
  end

  def edit
    @glaze = current_studio.glazes.find(params[:id])
  end

  def update
    current_studio.glazes.find(params[:id]).update! glaze_params

    redirect_to studio_glazes_path(current_studio), status: :see_other, notice: '釉薬を更新しました。'
  end

  def destroy
    if current_studio.glazes.find(params[:id]).destroy
      redirect_to studio_glazes_path(current_studio), status: :see_other, notice: '釉薬を削除しました。'
    else
      redirect_to studio_glazes_path(current_studio), status: :see_other, alert: 'すでに作品で使用されているため削除できません。'
    end
  end

  private

  def glaze_params
    params.expect(glaze: [
      :name
    ])
  end
end
