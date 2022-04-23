class UsersController < ApplicationController
  before_action :validate_user, except: [:create]

  def create
    username = params[:username]
    password = params[:password]
    unless username.match(/^[a-z0-9A-Z]+$/)
      render json: {'error': 'Nume invalid'}, status: :not_found
      return
    end

    if User.where(username: username).count > 0
      render json: {'error': 'Utilizatorul deja există'}, status: :not_found
      return
    end
    account = User.create(username: username, password: password)

    if account.save
      render json: {}, status: :ok
      return
    end
    render json: {}, status: :not_found
  end

  def get_current_user
    if @current_user
      response = ActiveModelSerializers::SerializableResource.new(
        @current_user,
        serializer: UserSerializer
      ).as_json
      render json: response and return
    end
    render json: {'error': 'Not logged in'}, status: :unauthorized
  end
end