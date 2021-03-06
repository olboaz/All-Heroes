class Review < ApplicationRecord
  belongs_to :user
  belongs_to :heroe

  validates :content, presence: true, length: { minimum: 5, maximum: 100 }
  validates :rating, presence: true, inclusion: (1..5)

  def blank_stars
    5 - rating.to_i
  end
end
