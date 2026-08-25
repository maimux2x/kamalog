class PiecePhoto < ApplicationRecord
  belongs_to :piece

  has_one_attached :file

  validates :file, attached: true

  positioned on: :piece
end
