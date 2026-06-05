class My::PiecesController < ApplicationController
  def index
    @studio = find_studio
    @pieces = current_user.pieces.order(:id)
  end

  def show
    @studio= find_studio
    @piece = current_user.pieces.includes(clay_usages: :clay, glaze_usages: :glaze).find(params[:id])
  end

  def new
    @studio= find_studio
    @piece = current_user.pieces.new

    @piece.clay_usages.build
  end

  def create
    @studio= find_studio
    @piece = current_user.pieces.new(piece_params)

    if @piece.save
      redirect_to studio_my_piece_path(@studio, @piece), status: :see_other, notice: '製作中の作品を登録しました。'
    else
      render :new, status: :unprocessable_content
    end
  end

  def edit
    @studio= find_studio
    @piece = current_user.pieces.find(params[:id])
  end

  def update
    @studio= find_studio
    @piece = current_user.pieces.find(params[:id])

    if @piece.update piece_params
      redirect_to studio_my_piece_path(@studio, @piece), status: :see_other, notice: '製作中の作品を更新しました。'
    else
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    studio= find_studio
    current_user.pieces.find(params[:id]).destroy!

    redirect_to studio_my_pieces_path(studio), status: :see_other, notice: '製作中の作品を削除しました。'
  end

  private

  def find_studio
    current_user.studios.first
  end

  def piece_params
    params.expect(piece: [
      :title,
      :status,
      :form_method,
      :description,

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
      ]],

      photos_attributes: [[
        :id,
        :file,
        :caption,
        :_destroy
      ]]
    ])
  end
end
