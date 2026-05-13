class Log < ApplicationRecord
  belongs_to :piece

  has_many :photos, dependent: :destroy
end
