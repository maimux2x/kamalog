class ClayUsage < ApplicationRecord
  belongs_to :piece
  belongs_to :clay

  validates :weight, presence: true

  enum :weight_unit, {
    g:  0,
    kg: 1
  }
end
