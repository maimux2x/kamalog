module Position
  extend ActiveSupport::Concern

  included do
    class_attribute :positioned_on

    after_destroy do
      on = instance_exec(&positioned_on)

      on.where('position > ?', position).update_all 'position = -position'
      on.where('position < ?', 0).update_all 'position = -position - 1'
    end
  end

  def move_to(position)
    on  = instance_exec(&positioned_on)
    arr = on.order(:position).to_a

    arr.delete self
    arr.insert position - 1, self

    cond = arr.size.times.map { 'WHEN ? THEN ?' }.join(' ')
    args = arr.flat_map.with_index(1) {|target, i| [target.id, i] }

    on.update_all 'position = -position'
    on.update_all ActiveRecord::Base.sanitize_sql_array(["position = CASE id #{cond} END", *args])
  end
end
