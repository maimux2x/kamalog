class Piece < ApplicationRecord
  belongs_to :membership

  has_one :user,   through: :membership
  has_one :studio, through: :membership

  has_many :clay_usages,  dependent: :destroy
  has_many :glaze_usages, dependent: :destroy
  has_many :logs,         dependent: :destroy

  has_many :clays,  through: :clay_usages
  has_many :glazes, through: :glaze_usages
  has_many :photos, through: :logs

  validates :title, presence: true
  validates :completed_at, presence: true, if: :complete?

  enum :status, {
    in_progress: 0,
    complete:    1
  }, validate: true

  enum :form_method, {
    hand_building:  0,
    coil_building:  1,
    ball_method:    2,
    slab_building:  3,
    electric_wheel: 4,
    other:          99
  }, validate: true

  accepts_nested_attributes_for :clay_usages,  allow_destroy: true
  accepts_nested_attributes_for :glaze_usages, allow_destroy: true, reject_if: :duplicated_glaze_usage
  accepts_nested_attributes_for :photos,       allow_destroy: true

  def duplicated_glaze_usage(attr)
    glaze_usages.any? { it.glaze_id.to_s == attr[:glaze_id] }
  end

  def complete = complete?

  def complete=(value)
    if ActiveRecord::Type::Boolean.new.cast(value)
      self.status         = :complete
      self.completed_at ||= Time.current
    else
      self.status       = :in_progress
      self.completed_at = nil
    end
  end
end
