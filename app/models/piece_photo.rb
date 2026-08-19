class PiecePhoto < ApplicationRecord
  belongs_to :piece

  has_one_attached :file

  validates :file, attached: true
end
