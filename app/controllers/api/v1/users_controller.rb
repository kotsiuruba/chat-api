module Api
  module V1
    class UsersController < ApplicationController
      before_action :authenticate, :except => :create

      def index
        render json: User.all
      end

      def  create
        user = User.create user_params
        if  user.persisted?
          render json: {
            user:{
              :id => user.id,
              :username => user.username,
              :messages_count => 0,
              :token => UserToken.generate(user.id)
            }
          }
        else
          render :json => { :errors => user.errors.full_messages }, :status => 422
        end
      end

      def show
        render json: User.find(params[:id])
      end

      protected
        def authenticate
          authenticate_or_request_with_http_token do |token, options|
            current_user = UserToken.get_user_id(token)
          end
        end

      private
        def user_params
          params.require(:user).permit(:username, :password)
        end

    end
  end
end
