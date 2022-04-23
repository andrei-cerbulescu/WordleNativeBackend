class User < ApplicationRecord
  has_secure_password
  validates :username, presence: true
  validates :username, uniqueness: true
  validates :username, length: {minimum: 4, maximum: 16}

  has_many :words, class_name: "Word", foreign_key: "user_id"
end
