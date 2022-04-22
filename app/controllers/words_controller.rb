class WordsController < ApplicationController
  before_action :validate_user

  def get
    word = Word.order(Arel.sql('RANDOM()')).first
    response = ActiveModelSerializers::SerializableResource.new(
      word,
      serializer: WordSerializer
    ).as_json

    render json: response
  end
end
