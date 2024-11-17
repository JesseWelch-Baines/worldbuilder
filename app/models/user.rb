class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  store :preferences, accessors: [
    :save_copy_of_paragraphs
  ]

  has_many :worlds
  # has_many :documents
  # has_many :characters
  # has_many :locations
  # has_many :items
  # has_many :events
  # has_many :paragraphs
  # has_many :writable_fields
end
