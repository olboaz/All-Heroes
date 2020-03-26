class User < ApplicationRecord
  has_many :heroes, through: :users_heroes
  validates :username, :first_name, :last_name presence: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
