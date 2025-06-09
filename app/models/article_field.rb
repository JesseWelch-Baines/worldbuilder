class ArticleField < ApplicationRecord
  belongs_to :user, inverse_of: :article_fields
  belongs_to :article_category, inverse_of: :article_fields
  has_many :article_field_values, dependent: :destroy, inverse_of: :article_field

  validates :name, presence: true

  def article_field_value(article_id)
    article_field_values.find_by(article_id: article_id)
  end
end
