class Log < ApplicationRecord
  belongs_to :piece

  has_many :log_photos, dependent: :destroy

  validates :date,  presence: true
  validates :title, presence: true

  accepts_nested_attributes_for :log_photos, allow_destroy: true
end
