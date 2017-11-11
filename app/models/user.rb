class User < ActiveRecord::Base
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable
  include DeviseTokenAuth::Concerns::User
  has_many :projects, dependent: :destroy

  validates :password, length: { minimum: 8 }, format: { with: /(?=.*?[a-zA-Z])(?=.*?[0-9])[\w-]{8,}/,
    message: I18n.t('errors.password_invalid') }, on: :create
end
