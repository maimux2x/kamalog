class Clays::BulksController < ApplicationController
  include CurrentMembership

  def new; end

  def create
    result = current_studio.clays.insert_all(params[:names].lines(chomp: true).compact_blank.map {|name|
      {name:}
    }, unique_by: :name)

    redirect_to studio_clays_path(current_studio), status: :see_other, notice: "#{result.rows.length}件の土を一括登録しました。"
  end
end
