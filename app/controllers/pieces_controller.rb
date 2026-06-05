class PiecesController < ApplicationController
  def index
    @pieces = current_user.studios.first.pieces.where(status: :complete).includes(:photos).order(:id)
  end

  def show
    @piece = current_user.studios.first.pieces.includes(:photos).find(params[:id])
  end
end
