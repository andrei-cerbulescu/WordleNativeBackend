class UsersController < ApplicationController
  before_action :validate_user

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