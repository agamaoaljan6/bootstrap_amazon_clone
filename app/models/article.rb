class Article < ApplicationRecord
    validates :title, presence: true
    validates :description, uniqueness: true
   
end
