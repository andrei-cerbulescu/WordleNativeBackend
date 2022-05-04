require "rails_helper"

RSpec.describe UsersController, type: :controller do
  before(:each) do
    @user = User.create(username: 'admin', password: '123')
    @token = JsonWebToken.encode(user_id: @user.id)
    @word = Word.create!(word: 'cuvant', user_id: @user.id)
  end

  describe 'Users Tests' do
    it 'Register user valid username' do
      post :create, params: {username: 'test123', password: '123456'}

      data = JSON.parse(response.body)
      expect(response.status).to eq(200)
      expect(User.count).to eq(2)
    end

    it 'Register user invalid username' do
      post :create, params: {username: 'test123!@', password: '123456'}

      data = JSON.parse(response.body)
      expect(response.status).to eq(404)
      expect(User.count).to eq(1)
    end

    it 'Register user duplicate username' do
      post :create, params: {username: 'admin', password: '123456'}

      data = JSON.parse(response.body)
      expect(response.status).to eq(404)
      expect(User.count).to eq(1)
    end

    it 'Get current user logged in' do
      request.headers["Authorization"] = @token
      get :get_current_user

      data = JSON.parse(response.body)
      expect(response.status).to eq(200)
      expect(data['username'].present?).to eq(true)
    end

    it 'Get current user not logged in' do
      get :get_current_user

      data = JSON.parse(response.body)
      expect(response.status).to eq(401)
      expect(data['error'].present?).to eq(true)
    end
  end
end