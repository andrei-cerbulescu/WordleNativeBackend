class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token

  def not_found
    render json: { error: 'not_found' }
  end

  def validate_user
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    begin
      @decoded = JsonWebToken.decode(header)
      @current_user = User.find(@decoded[:user_id]) unless @decoded.nil?
    end
    if @current_user.nil?
      render json: {error: 'Invalid login token'}, status: :unauthorized 
      return false
    end
  end
end
