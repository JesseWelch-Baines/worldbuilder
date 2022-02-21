class CreateWritableFields < ActiveRecord::Migration[6.1]
  def change
    create_table :writable_fields, id: :uuid do |t|
      t.references :user, null: false, type: :uuid
      t.references :world, null: false, type: :uuid
      t.string :model, null: false
      t.string :name, null: false
      t.integer :field_type, null: false, default: 0
      t.integer :order, null: false, default: 0
      t.integer :status, null: false, default: 0
      t.index :status

      t.timestamps
    end
  end
end
