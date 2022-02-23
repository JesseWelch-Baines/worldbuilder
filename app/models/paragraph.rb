class Paragraph < Writable
  belongs_to :user
  belongs_to :world
  has_many :writable_instances, as: :writable
  has_rich_text :description

  validates_presence_of :description

  enum status: { removed: -1, active: 0, archived: 1 }

  def title(limit)
    name.present? ? name : description.to_plain_text.truncate(limit, separator: ' ')
  end
end
