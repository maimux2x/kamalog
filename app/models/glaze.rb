class Glaze < ApplicationRecord
  has_many :glaze_usages, dependent: :destroy

  belongs_to :studio

  validates :name, presence: true
end
