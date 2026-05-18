class My::LogsController < ApplicationController
  def index
    @piece = current_user.pieces.find(params[:piece_id])
  end

  def show
    @log = find_piece.logs.find(params[:id])
  end

  def new
    @log = find_piece.logs.new(date: Date.current)
  end

  def create
    @log = find_piece.logs.new(log_params.except(:photos))

    Array(log_params.dig(:photos, :new_files)).each do |file|
      @log.photos.new file: file
    end

    if @log.save!
      redirect_to my_piece_log_path(@log.piece, @log), status: :see_other, notice: '作業記録を登録しました。'
    else
      render :new, status: :unprocessable_content
    end
  end

  def edit
    @log = find_piece.logs.find(params[:id])
  end

  def update
    @log = find_piece.logs.find(params[:id])

    Array(log_params.dig(:photos, :new_files)).each do |file|
      @log.photos.new file: file
    end

    @log.photos.where.not(id: Array(log_params.dig(:photos, :keep_ids))).destroy_all

    if @log.update!(log_params.except(:photos))
      redirect_to my_piece_log_path(@log.piece, @log), status: :see_other, notice: '作業記録を更新しました。'
    else
      render :edit, status: :unprocessable_content
    end
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

      photos: [
        new_files: [],
        keep_ids: []
      ]
    ])
  end

  def find_piece
    current_user.pieces.find(params[:piece_id])
  end
end
