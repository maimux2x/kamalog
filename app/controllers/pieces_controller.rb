class PiecesController < ApplicationController
  def index
    @pieces = Piece.where(status: :complete).includes(:photos).order(:id)
  end

  def show
    @piece = Piece.includes(:photos).find(params[:id])
  end
end
