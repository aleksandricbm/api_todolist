class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :trackable, :validatable
  include DeviseTokenAuth::Concerns::User
  has_many :projects, dependent: :destroy

  validates :password, length: { minimum: 8 }, format: { with: /\A(?=.*?[a-zA-Z])(?=.*?[0-9])[\w-]{8,}\z/,
    message: I18n.t('errors.password_invalid') }, on: :create
end
