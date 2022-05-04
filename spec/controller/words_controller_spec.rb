require "rails_helper"

RSpec.describe WordsController, type: :controller do
  before(:each) do
    @user = User.create(username: 'admin', password: '123')
    @token = JsonWebToken.encode(user_id: @user.id)
    @word = Word.create!(word: 'cuvant', user_id: @user.id)
  end

  describe 'Words Tests' do
    it 'Get random word' do

      request.headers["Authorization"] = @token
      get :get, params: {}

      data = JSON.parse(response.body)
      expect(response.status).to eq(200)
      expect(data['word'].present?).to eq(true)
      
    end

    it 'Get random word unauthorized' do

      get :get, params: {}

      data = JSON.parse(response.body)
      expect(response.status).to eq(401)
      
    end

    it 'Create new word' do
      request.headers["Authorization"] = @token
      post :create, params: {word: 'random'}

      expect(Word.count).to eq(2)
    end

    it 'Create new invalid word' do
      request.headers["Authorization"] = @token
      post :create, params: {word: '!23dvssdd'}

      expect(response.status).to eq(404)
      expect(Word.count).to eq(1)
    end

    it 'Create new invalid word' do
      request.headers["Authorization"] = @token
      post :create, params: {word: 'abcbasdfasfafdafadsfadsfds'}

      expect(response.status).to eq(404)
      expect(Word.count).to eq(1)
    end

    it 'Rate word' do
      @user.update(last_word_id: @word.id)
      request.headers["Authorization"] = @token

      post :rate, params: {word_id: @word.id, rating: 1}
      @word.reload

      expect(@word.thumbs_up).to eq(1)
    end

    it 'Rate word invalid' do
      @user.update(last_word_id: @word.id)
      request.headers["Authorization"] = @token

      post :rate, params: {word_id: 5, rating: 1}
      @word.reload

      expect(response.status).to eq(404)
      expect(@word.thumbs_up || 0).to eq(0)
    end
  end
end