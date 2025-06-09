class ArticleFieldValue < ApplicationRecord
  belongs_to :user, inverse_of: :article_field_values
  belongs_to :world, inverse_of: :article_field_values
  belongs_to :article, inverse_of: :article_field_values
  belongs_to :article_field, inverse_of: :article_field_values

  before_validation :set_user_and_world, on: :create

  private

  def set_user_and_world
    self.user ||= Current.user
    self.world ||= Current.world
  end
end
