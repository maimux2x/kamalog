class Piece < ApplicationRecord
  belongs_to :user

  has_many :piece_clays,  dependent: :destroy
  has_many :piece_glazes, dependent: :destroy

  has_many :clays,  through: :piece_clays
  has_many :glazes, through: :piece_glazes

  validates :title, presence: true

  enum :status, {
    in_progress: 0,
    complete:    1
  }, validate: true

  enum :form_method, {
    coil_building:  0,
    ball_method:    1,
    slab_building:  2,
    electric_wheel: 3
  }, validate: true
end
