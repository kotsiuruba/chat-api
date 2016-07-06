module Api
  module V1
    class SessionsController < ApplicationController

      def create

        user = User.where(:username => user_params[:username], :password => User.encrypt_password(user_params[:password])).first
        if user
          render json: {:token => UserToken.generate(user.id)}
        else
          render json: { :errors => "User not found" }, :status => 401
        end
      end

      private
        def user_params
          params.require(:user).permit(:username, :password)
        end

    end
  end
end
