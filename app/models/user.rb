class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable
  store :preferences, accessors: [
    :save_copy_of_paragraphs,
  ]

  has_many :worlds, dependent: :destroy, inverse_of: :user
  has_many :article_categories, dependent: :destroy, inverse_of: :user
  has_many :article_fields, dependent: :destroy, inverse_of: :user
  has_many :article_field_values, dependent: :destroy, inverse_of: :user

  has_many :documents, dependent: :destroy, inverse_of: :user
  has_many :paragraphs, dependent: :destroy, inverse_of: :user
  has_many :articles, dependent: :destroy, inverse_of: :user

  after_create :create_defaults

  private
  
  def create_defaults
    # Create a default world
    worlds.create(name: "My World") if worlds.empty?

    # Create default article categories
    if article_categories.empty?
      article_categories.create(name: "Character", colour: "#0000ff")
      article_categories.create(name: "Location", colour: "#009900")
      article_categories.create(name: "Event", colour: "#ff0000")
    end
  end
end
