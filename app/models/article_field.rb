class ArticleField < ApplicationRecord
  belongs_to :user, inverse_of: :article_fields
  belongs_to :article_category, inverse_of: :article_fields

  validates :name, presence: true
end
