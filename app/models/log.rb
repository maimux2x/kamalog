class Log < ApplicationRecord
  belongs_to :piece

  has_many :photos, dependent: :destroy, class_name: 'LogPhoto'

  validates :date,  presence: true
  validates :title, presence: true

  accepts_nested_attributes_for :photos, allow_destroy: true
end
