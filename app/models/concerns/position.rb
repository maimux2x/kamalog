module Position
  extend ActiveSupport::Concern

  class_methods do
    def positioned(on:, column: :position)
      quoted_column = ActiveRecord::Base.connection.quote_column_name(column)

      define_method :move_to do |position|
        rel = instance_exec(&on)
        arr = rel.order(column).to_a

        arr.delete self
        arr.insert position - 1, self

        cond = arr.size.times.map { 'WHEN ? THEN ?' }.join(' ')
        args = arr.flat_map.with_index(1) {|target, i| [target.id, i] }

        rel.update_all "#{quoted_column} = -#{quoted_column}"
        rel.update_all ActiveRecord::Base.sanitize_sql_array(["#{quoted_column} = CASE id #{cond} END", *args])
      end

      after_destroy do
        rel = instance_exec(&on)

        rel.where("#{quoted_column} > ?", self[column]).update_all "#{quoted_column} = -#{quoted_column}"
        rel.where("#{quoted_column} < ?", 0).update_all "#{quoted_column} = -#{quoted_column} - 1"
      end
    end
  end
end
