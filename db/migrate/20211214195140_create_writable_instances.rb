class CreateWritableInstances < ActiveRecord::Migration[6.1]
  def change
    create_table :writable_instances, id: :uuid do |t|
      t.references :user, null: false, type: :uuid
      t.references :document, null: false, type: :uuid
      t.uuid :writable_id, null: false
      t.string :writable_type, null: false
      t.index [:writable_id, :writable_type]
      t.integer :order
      t.integer :status, null: false, default: 0
      t.index :status

      t.timestamps
    end
  end
end
