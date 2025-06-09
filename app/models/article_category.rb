class ArticleCategory < ApplicationRecord
  belongs_to :user
  has_many :articles, dependent: :restrict_with_error, inverse_of: :category
  has_many :article_fields, dependent: :destroy, inverse_of: :article_category
  has_many :article_field_values, through: :article_fields

  validates :name, presence: true
end
