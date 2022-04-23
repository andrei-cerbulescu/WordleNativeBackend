class WordsController < ApplicationController
  before_action :validate_user

  def get
    word = Word.order(Arel.sql('RANDOM()')).first
    @current_user.update(last_word_id: word.id)
    response = ActiveModelSerializers::SerializableResource.new(
      word,
      serializer: WordSerializer
    ).as_json

    render json: response
  end

  def create
    text = params[:word].downcase

    unless text.match(/^[a-zăîșțâ]+$/)
      render json: {'error': 'Cuvânt invalid'}, status: :not_found
      return
    end

    if text.length > 10
      render json: {'error': 'Cuvânt prea lung'}, status: :not_found
      return
    end

    word = Word.create(word: text, user_id: @current_user.id)
    if word.save
      render json: {}, status: :ok
      return
    end

      render json: {'error': 'Cuvantul deja exista'}, status: :not_found
  end

  def rate
    word_id = params[:word_id]
    if @current_user.last_word_id != word_id
      render json: {'error': 'Invalid word_id'}, status: :not_found
      return
    end

    word = Word.where(id: word_id).first

    if params[:rating]>0
      word.update(thumbs_up: (word.thumbs_up || 0)+1)
    else
      word.update(thumbs_up: (word.thumbs_down || 0)+1)
    end
    @current_user.update(last_word_id: nil)
    render json: {}, status: :ok
  end
end
