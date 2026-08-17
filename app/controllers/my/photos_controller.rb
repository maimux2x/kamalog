class My::PhotosController < ApplicationController
  include CurrentMembership

  def update
    piece = current_studio.pieces.find(params[:piece_id])
    photo = piece.photos.find(params[:id])

    photo.move_to(params[:position].to_i)

    head :no_content
  end
end
