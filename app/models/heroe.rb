class Heroe < ApplicationRecord
  belongs_to :publisher
  has_many :users, through: :users_heroes

  validates :name, :description, :address, :image_hero, :height, :weight,  presence: true

end
