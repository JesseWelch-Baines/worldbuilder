class CreateLocations < ActiveRecord::Migration[6.1]
  def change
    create_table :locations, id: :uuid do |t|
      t.references :user, null: false, type: :uuid
      t.string :name, null: false
      t.integer :status, null: false, default: 0
      t.index :status

      t.timestamps
    end
  end
end
