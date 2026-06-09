class PiecesController < ApplicationController
  include CurrentMembership

  def index
    @pieces = current_studio.pieces.where(status: :complete).includes(:photos).order(:id)
  end

  def show
    @piece = current_studio.pieces.includes(:photos).find(params[:id])
  end
end
