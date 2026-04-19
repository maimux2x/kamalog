class My::PiecesController < ApplicationController
  def show
    @piece = current_user.pieces.find(params[:id])
  end

  def new
    @piece = current_user.pieces.new

    @piece.clay_usages.build
  end

  def create
    @piece = current_user.pieces.create!(piece_params)

    redirect_to my_piece_path(@piece), status: :see_other
  end

  def edit
    @piece = current_user.pieces.find(params[:id])
  end

  def update
    @piece = current_user.pieces.find(params[:id])
    @piece.update! piece_params

    redirect_to my_piece_path(@piece), status: :see_other
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
