class Clay < ApplicationRecord
  has_many :piece_clays, dependent: :destroy

  validates :name, presence: true
end
