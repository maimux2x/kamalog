class Step < ApplicationRecord
  belongs_to :log
  belongs_to :kind, class_name: 'StepKind'
end
