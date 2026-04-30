class My::PiecesController < ApplicationController
  def show
    @piece = current_user.pieces.includes(clay_usages: :clay, glaze_usages: :glaze).find(params[:id])
  end

  def new
    @piece = current_user.pieces.new

    @piece.clay_usages.build
  end

  def create
    @piece = current_user.pieces.new(piece_params)

    if @piece.save
      redirect_to my_piece_path(@piece), status: :see_other, notice: '製作中の作品を登録しました。'
    else
      render :new, status: :unprocessable_content
    end
  end

  def edit
    @piece = current_user.pieces.find(params[:id])
  end

  def update
    @piece = current_user.pieces.find(params[:id])

    if @piece.update piece_params
      redirect_to my_piece_path(@piece), status: :see_other, notice: '製作中の作品を更新しました。'
    else
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    current_user.pieces.find(params[:id]).destroy!

    redirect_to my_in_progress_index_path, status: :see_other, notice: '製作中の作品を削除しました。'
  end

  private

  def piece_params
    params.expect(piece: [
      :title,
      :status,
      :form_method,

      clay_usages_attributes: [[
        :clay_id,
        :weight,
        :id,
        :_destroy
      ]],

      glaze_usages_attributes: [[
        :glaze_id,
        :id,
        :_destroy
      ]]
    ])
  end
end
