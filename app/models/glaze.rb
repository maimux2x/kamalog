class Glaze < ApplicationRecord
  has_many :piece_glazes, dependent: :destroy

  validates :name, presence: true
end
