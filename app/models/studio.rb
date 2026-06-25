class Studio < ApplicationRecord
  has_many :memberships, dependent: :destroy
  has_many :clays,       dependent: :destroy
  has_many :glazes,      dependent: :destroy

  has_many :users, through: :memberships

  has_many :pieces, through: :memberships

  def invitation_enabled?
    !!invitation_token
  end
end
