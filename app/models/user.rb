class User < ApplicationRecord
  has_one_attached :avatar do |attachable|
    attachable.variant :small, resize_to_limit: [200, 200]
  end

  has_many :pieces, dependent: :destroy
end
