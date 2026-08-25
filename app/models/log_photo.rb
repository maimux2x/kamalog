class LogPhoto < ApplicationRecord
  belongs_to :log

  has_one_attached :file

  validates :file, attached: true

  positioned on: :log
end
