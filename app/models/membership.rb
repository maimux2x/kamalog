class Membership < ApplicationRecord
  belongs_to :studio
  belongs_to :user
end
