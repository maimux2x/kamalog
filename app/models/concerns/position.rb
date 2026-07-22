module Position
  extend ActiveSupport::Concern

  class_methods do
    def positioned(on:)
      define_method :move_to do |position|
        rel = instance_exec(&on)
        arr = rel.order(:position).to_a

        arr.delete self
        arr.insert position - 1, self

        cond = arr.size.times.map { 'WHEN ? THEN ?' }.join(' ')
        args = arr.flat_map.with_index(1) {|target, i| [target.id, i] }

        rel.update_all 'position = -position'
        rel.update_all ActiveRecord::Base.sanitize_sql_array(["position = CASE id #{cond} END", *args])
      end

      after_destroy do
        rel = instance_exec(&on)

        rel.where('position > ?', position).update_all 'position = -position'
        rel.where('position < ?', 0).update_all 'position = -position - 1'
      end
    end
  end
end
