class Heroe < ApplicationRecord
  belongs_to :publisher
  belongs_to :user
  has_many_attached :photos
  has_many :likes, dependent: :destroy
  has_many :reviews, dependent: :destroy

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  validates :name, :description, :address, :height, :weight, presence: true
  validates :name, uniqueness:  true

end
