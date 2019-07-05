class Review < ApplicationRecord
  belongs_to :product
  validates(:body, presence: true)
  validates(:rating, numericality: { less_than_or_equal_to: 5 }) 
end
