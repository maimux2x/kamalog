class PiecePhoto < ApplicationRecord
  include Position

  belongs_to :piece

  has_one_attached :file

  validates :file, attached: true

  self.positioned_on = -> { piece.photos }
end
