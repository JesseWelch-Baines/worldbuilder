class AddWorldReferenceToTables < ActiveRecord::Migration[6.1]
  def change
    add_reference :documents, :world, index: true, type: :uuid, null: false
    add_reference :paragraphs, :world, index: true, type: :uuid, null: false
    add_reference :characters, :world, index: true, type: :uuid, null: false
    add_reference :locations, :world, index: true, type: :uuid, null: false
    add_reference :items, :world, index: true, type: :uuid, null: false
    add_reference :events, :world, index: true, type: :uuid, null: false
  end
end
