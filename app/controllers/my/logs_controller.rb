class My::LogsController < ApplicationController
  def index
    @studio = find_studio
    @piece = current_user.pieces.includes(:logs).find(params[:piece_id])
  end

  def show
    @studio = find_studio
    @log = find_piece.logs.find(params[:id])
  end

  def new
    @studio = find_studio
    @log = find_piece.logs.new(date: Date.current)
  end

  def create
    @studio = find_studio
    log = find_piece.logs.create!(log_params)

    redirect_to studio_my_piece_log_path(@studio, log.piece, log), status: :see_other, notice: '作業記録を登録しました。'
  end

  def edit
    @studio = find_studio
    @log = find_piece.logs.find(params[:id])
  end

  def update
    @studio = find_studio
    log = find_piece.logs.find(params[:id])

    log.update! log_params
    redirect_to studio_my_piece_log_path(@studio, log.piece, log), status: :see_other, notice: '作業記録を更新しました。'
  end

  def destroy
    studio = find_studio
    piece = find_piece
    piece.logs.find(params[:id]).destroy!

    redirect_to studio_my_piece_logs_path(studio, piece), status: :see_other, notice: '作業記録を削除しました。'
  end

  private

  def find_studio
    Studio.find(params[:studio_id])
  end

  def log_params
    params.expect(log: [
      :date,
      :title,
      :body,

      photos_attributes: [[
        :id,
        :file,
        :caption,
        :_destroy
      ]]
    ])
  end

  def find_piece
    current_user.pieces.find(params[:piece_id])
  end
end
