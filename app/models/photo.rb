class Photo < ApplicationRecord
  belongs_to :log

  has_one_attached :file do |attachable|
    attachable.variant :small, resize_to_limit: [100, 100]
  end
end
