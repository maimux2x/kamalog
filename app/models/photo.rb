class Photo < ApplicationRecord
  belongs_to :log

  has_one_attached :file
end
