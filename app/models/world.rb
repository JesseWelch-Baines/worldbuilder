class World < ApplicationRecord
  include Utilities

  belongs_to :user
end
