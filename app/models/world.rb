class World < ApplicationRecord
  include Utilities

  belongs_to :user

  validates :name, presence: true
end
