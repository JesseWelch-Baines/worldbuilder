class CreateArticleCategories < ActiveRecord::Migration[8.0]
  def change
    create_table :article_categories, id: :uuid do |t|
      t.references :user, null: false, type: :uuid
      t.string :name, null: false
      t.string :colour, limit: 7
      t.integer :status, null: false, default: 0
      t.index :status

      t.timestamps
    end
  end
end
