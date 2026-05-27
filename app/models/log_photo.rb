class LogPhoto < ApplicationRecord
  belongs_to :log

  has_one_attached :file
  validates :file, attached: true
end
