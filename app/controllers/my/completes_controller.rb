class My::CompletesController < ApplicationController
  def new
    @piece = current_user.pieces.find(params[:piece_id])
  end
end
