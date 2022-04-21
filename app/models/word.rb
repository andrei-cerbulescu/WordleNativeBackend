class Word < ApplicationRecord
  def caluleaza_ratio
    return 0 unless thumbs_up && thumbs_down
    return thumbs_up.to_f/thumbs_down
  end
end