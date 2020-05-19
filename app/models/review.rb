class Review < ApplicationRecord
  belongs_to :heroe

  validates :content, :rating,  presence: true
end
