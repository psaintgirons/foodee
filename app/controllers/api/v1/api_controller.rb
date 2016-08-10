class API::V1::ApiController < ActionController::Base
  before_action :authenticate
  respond_to :json

  rescue_from StandardError do |exception|
    render json: { error:  exception.message }, status: :internal_server_error
  end

  protected

  def authenticate
    authenticate_token || render_unauthorized
  end

  def authenticate_token
    authenticate_with_http_token do |token, options|
      User.find_by(auth_token: token)
    end
  end

  def render_unauthorized
    render json: 'Bad credentials', status: :unauthorized
  end
end
