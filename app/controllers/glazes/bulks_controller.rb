class Glazes::BulksController < ApplicationController
  include CurrentMembership

  def new; end

  def create
    glazes        = current_studio.glazes
    base_position = glazes.count

    result = glazes.insert_all(params[:names].lines(chomp: true).compact_blank.map.with_index(1) {|name, i|
      {
        name:,
        position: base_position + i
      }
    }, unique_by: [:studio_id, :name])

    redirect_to studio_glazes_path(current_studio), status: :see_other, notice: "#{result.length}件の釉薬を一括登録しました。"
  end
end
