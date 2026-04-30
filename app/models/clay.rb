class Clay < ApplicationRecord
  has_many :clay_usages, dependent: :destroy

  validates :name, presence: true
end
