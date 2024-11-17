class CreateArticleInstances < ActiveRecord::Migration[8.0]
  def change
    create_table :article_instances, id: :uuid do |t|
      t.references :user, null: false, type: :uuid
      t.references :document, null: false, type: :uuid
      t.uuid :article_id, null: false
      t.string :article_type, null: false
      t.index [:article_id, :article_type]
      t.integer :order
      t.integer :status, null: false, default: 0
      t.index :status

      t.timestamps
    end
  end
end
