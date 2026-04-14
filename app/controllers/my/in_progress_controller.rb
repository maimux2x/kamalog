class My::InProgressController < ApplicationController
  def index
    @pieces = current_user.pieces.order(id: :desc)
  end
end
