class Piece < ApplicationRecord
  belongs_to :user

  has_many :clay_usages,  dependent: :destroy
  has_many :glaze_usages, dependent: :destroy

  has_many :clays,  through: :clay_usages
  has_many :glazes, through: :glaze_usages

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

  accepts_nested_attributes_for :clay_usages, :glaze_usages
end
