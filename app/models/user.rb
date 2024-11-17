class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable
  store :preferences, accessors: [
    :save_copy_of_paragraphs,
  ]

  has_many :worlds
  has_many :article_categories

  has_many :documents
  has_many :paragraphs
  has_many :articles
  # has_many :article_fields
end
