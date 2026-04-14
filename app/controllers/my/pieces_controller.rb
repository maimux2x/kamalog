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

    redirect_to my_in_progress_index_path, status: :see_other
  end

  private

  def piece_params
    params.expect(piece: [
      :title,
      :status,
      :form_method,

      clay_usages_attributes: [[
        :clay_id,
        :weight
      ]],

      glaze_usages_attributes: [[
        :glaze_id
      ]]
    ])
  end
end
