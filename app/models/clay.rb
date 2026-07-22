class Clay < ApplicationRecord
  include Position

  has_many :clay_usages, dependent: :restrict_with_error

  belongs_to :studio

  validates :name, presence: true, uniqueness: {scope: :studio_id}

  positioned on: -> { studio.clays }
end
