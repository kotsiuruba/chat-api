class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods
  attr_accessor :current_user

  protected
  def authenticate
    authenticate_or_request_with_http_token do |token, options|
      self.current_user = UserToken.get_user_id(token).to_i
      self.current_user > 0
    end
  end
end
