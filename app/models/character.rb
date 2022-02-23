class Character < Writable
  belongs_to :user
  belongs_to :world
  has_many :writable_instances, as: :writable
  has_rich_text :description

  validates_presence_of :name
  validates :name, uniqueness: {scope: [:user, :world]}

  #default_scope { where(world_id: Current.world.id) }
end

