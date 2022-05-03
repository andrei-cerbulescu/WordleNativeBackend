require "rails_helper"

RSpec.describe WordsController, type: :controller do
  before(:each) do
    @user = User.create(username: 'admin', password: '123')
    @token = JsonWebToken.encode(user_id: @user.id)
    Word.create!(word: 'cuvant', user_id: @user.id)
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
  end
end