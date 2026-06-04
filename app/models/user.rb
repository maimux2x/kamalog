class User < ApplicationRecord
  has_one_attached :avatar do |attachable|
    attachable.variant :small, resize_to_limit: [200, 200]
    attachable.variant :icon, resize_to_limit: [100, 100]
  end

  has_many :pieces,      dependent: :destroy
  has_many :memberships, dependent: :destroy

  has_many :studios, through: :memberships

  accepts_nested_attributes_for :memberships
end
