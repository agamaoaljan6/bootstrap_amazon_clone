class User < ApplicationRecord
    has_secure_password

    has_many :products, class_name: "Product", dependent: :nullify
    has_many :reviews, class_name: "Review", dependent: :nullify


    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, uniqueness: true, 
    format: { with: VALID_EMAIL_REGEX }
end

