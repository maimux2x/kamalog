class My::LogsController < ApplicationController
  def index
    @piece = current_user.pieces.includes(:logs).find(params[:piece_id])
  end

  def show
    @log = find_piece.logs.find(params[:id])
  end

  def new
    @log = find_piece.logs.new(date: Date.current)
  end

  def create
    log = find_piece.logs.create!(log_params)

    redirect_to my_piece_log_path(log.piece, log), status: :see_other, notice: '作業記録を登録しました。'
  end

  def edit
    @log = find_piece.logs.find(params[:id])
  end

  def update
    log = find_piece.logs.find(params[:id])

    log.update! log_params
    redirect_to my_piece_log_path(log.piece, log), status: :see_other, notice: '作業記録を更新しました。'
  end

  def destroy
    piece = find_piece
    piece.logs.find(params[:id]).destroy!

    redirect_to my_piece_logs_path(piece), status: :see_other, notice: '作業記録を削除しました。'
  end

  private

  def log_params
    params.expect(log: [
      :date,
      :title,
      :body,

      photos_attributes: [[
        :id,
        :file,
        :_destroy,
        :caption
      ]]
    ])
  end

  def find_piece
    current_user.pieces.find(params[:piece_id])
  end
end
