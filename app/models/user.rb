class User < ApplicationRecord
  extend Devise::Models
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  include DeviseTokenAuth::Concerns::User

  mount_uploader :photo, PhotoUploader

  has_many :offers
  has_many :favorites
  has_many :favorite_offers, through: :favorites, source: :offer
end
