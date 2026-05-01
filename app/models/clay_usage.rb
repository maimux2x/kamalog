class ClayUsage < ApplicationRecord
  belongs_to :piece
  belongs_to :clay

  validates :weight, presence: true
end
