class Piece < ApplicationRecord
  belongs_to :membership

  has_many :clay_usages,  dependent: :destroy
  has_many :glaze_usages, dependent: :destroy
  has_many :logs,         dependent: :destroy
  has_many :photos,       dependent: :destroy, class_name: 'PiecePhoto'

  has_many :clays,  through: :clay_usages
  has_many :glazes, through: :glaze_usages

  validates :title, presence: true

  enum :status, {
    in_progress: 0,
    complete:    1
  }, validate: true

  enum :form_method, {
    hand_building:  0,
    coil_building:  1,
    ball_method:    2,
    slab_building:  3,
    electric_wheel: 4,
    other:          99
  }, validate: true

  accepts_nested_attributes_for :clay_usages,  allow_destroy: true
  accepts_nested_attributes_for :glaze_usages, allow_destroy: true
  accepts_nested_attributes_for :photos,       allow_destroy: true
end
