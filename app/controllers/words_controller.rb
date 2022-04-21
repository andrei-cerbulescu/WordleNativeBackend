class WordsController < ApplicationController
  def get
    word = Word.order(Arel.sql('RANDOM()')).first
    render word.to_json
  end
end
