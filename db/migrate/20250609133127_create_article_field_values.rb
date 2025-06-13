class CreateArticleFieldValues < ActiveRecord::Migration[8.0]
  def change
    create_table :article_field_values, id: :uuid do |t|
      t.references :user, null: false, type: :uuid
      t.references :article, null: false, type: :uuid
      t.references :article_field, null: false, type: :uuid
      t.string :value

      t.timestamps
    end
  end
end
