class User < ApplicationRecord
    has_secure_password

    validates :name, 
        presence: true,
        uniqueness: true,
        length: { maximum: 30 }

    validates :full_name,
        presence: true,
        length: { maximum: 30 }

    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email,
        presence: true,
        uniqueness: true,
        length: { maximum: 50 },
        format: { with: VALID_EMAIL_REGEX }

    VALID_PASSWORD_REGEX = /(?=.*\d+.*)(?=.*[a-zA-Z]+.*).*[!@#$%]+.*/
    validates :password,
        presence: true,
        length: { minimum: 8, maximum: 30 },
        format: { with: VALID_PASSWORD_REGEX }

end