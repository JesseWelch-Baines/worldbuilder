class CreateDocuments < ActiveRecord::Migration[8.0]
  def change
    create_table :documents, id: :uuid do |t|
      t.references :user, null: false, type: :uuid
      t.references :world, null: false, type: :uuid
      t.string :name, null: false
      t.integer :status, null: false, default: 0
      t.index :status

      t.timestamps
    end
  end
end
