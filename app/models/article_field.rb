class ArticleField < ApplicationRecord
  belongs_to :user, inverse_of: :article_fields
  belongs_to :article_category, inverse_of: :article_fields

  before_validation :set_world

  validates :name, presence: true

  private

  def set_world
    return if world_id.present?

    self.world_id = Current.world.id if Current.world.present?
  end
end
