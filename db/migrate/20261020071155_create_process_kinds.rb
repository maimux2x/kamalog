class CreateProcessKinds < ActiveRecord::Migration[8.1]
  def change
    create_table :process_kinds do |t|
      t.references :studio,   null: false
      t.string     :name,     null: false
      t.integer    :position, null: false

      t.timestamps

      t.index %i[studio_id position], unique: true
    end

    create_table :processes do |t|
      t.references :log,          null: false
      t.references :process_kind, null: false
    end
  end
end
