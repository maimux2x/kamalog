module PositionAttributes
  extend ActiveSupport::Concern

  private

  def set_position(attrs)
    return unless attrs

    attrs.values.reject { it[:_destroy] }.each.with_index 1 do |attr, i|
      attr[:position] = i
    end
  end
end
