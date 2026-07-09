class Clays::BulksController < ApplicationController
  include CurrentMembership

  def new; end

  def create
    base_position = current_studio.clays.count

    result = current_studio.clays.insert_all(params[:names].lines(chomp: true).compact_blank.map.with_index(1) {|name, i|
      {
        name:,
        position: base_position + i
      }
    }, unique_by: [:studio_id, :name])

    redirect_to studio_clays_path(current_studio), status: :see_other, notice: "#{result.length}件の土を一括登録しました。"
  end
end
