class WordSerializer < ActiveModel::Serializer
  attributes :word, :thumbs_up, :thumbs_down
end
