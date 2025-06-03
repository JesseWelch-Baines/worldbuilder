class ArticleCategory < ApplicationRecord
  belongs_to :user
  has_many :articles, dependent: :restrict_with_error, inverse_of: :category
end
