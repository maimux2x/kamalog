class User < ApplicationRecord
  has_one_attached :avatar

  has_many :pieces, dependent: :destroy
end
