class World < ApplicationRecord
  include Utilities

  belongs_to :user
  has_many :article_field_values, dependent: :destroy, inverse_of: :world

  validates :name, presence: true
end
