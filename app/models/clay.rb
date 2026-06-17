class Clay < ApplicationRecord
  has_many :clay_usages, dependent: :restrict_with_error

  belongs_to :studio

  validates :name, presence: true, uniqueness: true
end
