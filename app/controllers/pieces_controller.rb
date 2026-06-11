class PiecesController < ApplicationController
  include CurrentMembership

  def index
    @pieces = current_studio.pieces.where(status: :complete).order(id: :desc)
  end

  def show
    @piece = current_studio.pieces.find(params[:id])
  end
end
