class StepKind < ApplicationRecord
  has_many :steps, dependent: :destroy, foreign_key: :kind_id

  belongs_to :studio

  positioned on: :studio
end
