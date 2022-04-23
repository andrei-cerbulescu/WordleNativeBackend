class Word < ApplicationRecord
  belongs_to :user, class_name: "User", foreign_key: "user_id"
  validates :word, uniqueness: true
end