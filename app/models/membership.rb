class Membership < ApplicationRecord
  has_many :pieces, dependent: :destroy

  belongs_to :studio
  belongs_to :user
end
