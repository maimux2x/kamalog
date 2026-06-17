class ClaysController < ApplicationController
  include CurrentMembership

  def index
    @clays = current_studio.clays.order(:id)
  end

  def new
    @clay = current_studio.clays.new
  end

  def create
    @clay = current_studio.clays.new(clay_params)

    if @clay.save
      redirect_to studio_clays_path, status: :see_other, notice: '土を登録しました。'
    else
      render :new, status: :unprocessable_content
    end
  end

  def edit
    @clay = current_studio.clays.find(params[:id])
  end

  def update
    @clay = current_studio.clays.find(params[:id])

    if @clay.update(clay_params)
      redirect_to studio_clays_path(current_studio), status: :see_other, notice: '土を更新しました。'
    else
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    if current_studio.clays.find(params[:id]).destroy
      redirect_to studio_clays_path(current_studio), status: :see_other, notice: '土を削除しました。'
    else
      redirect_to studio_clays_path(current_studio), status: :see_other, alert: 'すでに作品で使用されているため削除できません。'
    end
  end

  private

  def clay_params
    params.expect(clay: [
      :name
    ])
  end
end
