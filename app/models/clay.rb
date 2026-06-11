class Clay < ApplicationRecord
  has_many :clay_usages, dependent: :destroy

  belongs_to :studio

  validates :name, presence: true
end
