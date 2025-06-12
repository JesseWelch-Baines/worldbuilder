class ArticleFieldValue < ApplicationRecord
  belongs_to :user, inverse_of: :article_field_values
  belongs_to :article, inverse_of: :article_field_values
  belongs_to :article_field, inverse_of: :article_field_values
end
