class Publisher < ApplicationRecord
  has_many :heroes
  validates :name, presence: true
end
