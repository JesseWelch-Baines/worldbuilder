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

  has_many :documents, dependent: :destroy, inverse_of: :user
  has_many :paragraphs, dependent: :destroy, inverse_of: :user
  has_many :articles, dependent: :destroy, inverse_of: :user
  # has_many :article_fields
end
