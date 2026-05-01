class Log < ApplicationRecord
  belongs_to :piece

  has_many :photos

  accepts_nested_attributes_for :photos
end
