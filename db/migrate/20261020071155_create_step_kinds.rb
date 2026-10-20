class CreateStepKinds < ActiveRecord::Migration[8.1]
  def change
    create_table :step_kinds do |t|
      t.references :studio,   null: false
      t.string     :name,     null: false
      t.integer    :position, null: false

      t.timestamps

      t.index %i[studio_id position], unique: true
    end

    create_table :steps do |t|
      t.references :log,          null: false
      t.references :step_kind, null: false
    end
  end
end
