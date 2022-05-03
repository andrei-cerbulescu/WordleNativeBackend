class WordSerializer < ActiveModel::Serializer
  attributes :word, :thumbs_up, :thumbs_down, :id

  attribute :rating do
    object.rating
  end
end
