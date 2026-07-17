module Position
  extend ActiveSupport::Concern

  included do
    after_destroy do
      positioned_on.where('position > ?', position).update_all 'position = -position'
      positioned_on.where('position < ?', 0).update_all 'position = -position - 1'
    end
  end

  def move_to(position)
    arr = positioned_on.order(:position).to_a

    arr.delete self
    arr.insert position - 1, self

    cond = arr.size.times.map { 'WHEN ? THEN ?' }.join(' ')
    args = arr.flat_map.with_index(1) {|target, i| [target.id, i] }

    positioned_on.update_all 'position = -position'
    positioned_on.update_all ActiveRecord::Base.sanitize_sql_array(["position = CASE id #{cond} END", *args])
  end
end
