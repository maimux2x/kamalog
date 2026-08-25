class PiecesController < ApplicationController
  include CurrentMembership

  def index
    @pagy, @pieces = pagy(current_studio.pieces.where(status: :complete).order(created_at: :desc))
  end

  def show
    @piece = current_studio.pieces.find(params[:id])
  end
end
