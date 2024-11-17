class Paragraph < ApplicationRecord
  belongs_to :user
  belongs_to :world
  has_many :article_instances
  has_rich_text :description

  validates :description, presence: true

  enum :status, { removed: -1, active: 0, archived: 1 }

  def title(limit)
    name.presence || description.to_plain_text.truncate(limit, separator: " ")
  end
end
