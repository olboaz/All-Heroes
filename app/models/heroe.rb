class Heroe < ApplicationRecord
  belongs_to :publisher
  has_many :users, through: :users_heroes
  has_many_attached :photos

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  validates :name, :description, :address, :image_hero, :height, :weight,  presence: true
  validates :name, uniqueness:  true

end
