class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods
  attr_accessor :current_user

  protected
  def authenticate
    authenticate_or_request_with_http_token do |token, options|
      # get user id by token and return false, if token not found
      self.current_user = UserToken.get_user_id(token)
      self.current_user > 0
    end
  end
end
