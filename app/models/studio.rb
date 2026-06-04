class Studio < ApplicationRecord
  has_many :memberships, dependent: :destroy
  has_many :clays,       dependent: :destroy
  has_many :glazes,      dependent: :destroy
end
