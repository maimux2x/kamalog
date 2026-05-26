class My::CompletesController < ApplicationController
  def new
    @piece = current_user.pieces.find(params[:piece_id])
  end

  def create
    piece = current_user.pieces.find(params[:piece_id])

    piece.update! status: :complete, **piece_params

    redirect_to my_piece_path(piece), status: :see_other, notice: '作品を完成品に更新しました。'
  end

  private

  def piece_params
    params.expect(piece: [
      :description,

      photos_attributes: [[
        :id,
        :file,
        :caption,
        :_destroy
      ]]
    ])
  end
end
