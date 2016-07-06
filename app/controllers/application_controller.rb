class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods
  attr_accessor :current_user
end
