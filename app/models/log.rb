class Log < ApplicationRecord
  belongs_to :piece

  has_many :photos, dependent: :destroy, class_name: 'LogPhoto'
  has_many :steps,  dependent: :destroy

  has_many :kinds, through: :steps

  validates :date,  presence: true

  accepts_nested_attributes_for :photos, allow_destroy: true
  accepts_nested_attributes_for :piece
end
