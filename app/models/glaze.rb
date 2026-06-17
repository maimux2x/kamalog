class Glaze < ApplicationRecord
  has_many :glaze_usages, dependent: :restrict_with_error

  belongs_to :studio

  validates :name, presence: true, uniqueness: true
end
