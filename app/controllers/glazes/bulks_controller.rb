class Glazes::BulksController < ApplicationController
  include CurrentMembership

  def new; end

  def create
    result = current_studio.glazes.insert_all(params[:names].lines(chomp: true).compact_blank.map {|name|
      {name:}
    }, unique_by: :name)

    redirect_to studio_glazes_path(current_studio), status: :see_other, notice: "#{result.length}件の釉薬を一括登録しました。"
  end
end
