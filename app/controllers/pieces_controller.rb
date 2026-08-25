class PiecesController < ApplicationController
  include CurrentMembership

  def index
    @pagy, @pieces = pagy(current_studio.pieces.complete.order({completed_at: :desc}, :id))
  end

  def show
    @piece = current_studio.pieces.find(params[:id])
  end
end
