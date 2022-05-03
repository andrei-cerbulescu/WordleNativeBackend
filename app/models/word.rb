class Word < ApplicationRecord
  belongs_to :user, class_name: "User", foreign_key: "user_id"
  validates :word, uniqueness: true

  def rating
    divide_by = (object.thumbs_up || 0) + (object.thumbs_down || 0)
    divide_by = 1 if divide_by==0
    (((object.thumbs_up || 0).to_f / divide_by).floor(4)*100).round(2)
  end
end