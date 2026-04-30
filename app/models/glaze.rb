class Glaze < ApplicationRecord
  has_many :glaze_usages, dependent: :destroy
  validates :name, presence: true
end
