class CreateArticles < ActiveRecord::Migration[8.0]
  def change
    create_table :articles, id: :uuid do |t|
      t.references :user, null: false, type: :uuid
      t.references :article_category, null: false, type: :uuid
      t.string :name, null: false
      t.integer :status, null: false, default: 0
      t.index :status

      t.timestamps
    end
  end
end
