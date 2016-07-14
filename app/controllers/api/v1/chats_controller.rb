module Api
  module V1
    class ChatsController < ApplicationController
      before_action :authenticate

      def create
        chat = Chat.new chat_params
        if chat.save
          # add creator to chat
          chat.users << User.find(current_user)
          render :json => chat
        else
          render :json => {
            :errors => chat.errors.full_messages
          }, :status => 422
        end
      end

      def index
        render :json => Chat.joins(:users).where("users.id" => current_user).all
      end

      def show
        render :json => Chat.find(params[:id])
      end

      def update

        chat = Chat.find(params[:id])
        curent_user_obj = User.find(current_user)
        if chat.include_user? curent_user_obj
          if chat.update chat_params
            # add to chat user, who manage chat if list of users edited
            chat.users << curent_user_obj if !params[:chat][:user_ids].nil?
            render :json => chat
          else
            render :json => {
              :errors => chat.errors.full_messages
            }, :status => 422
          end
        else
          render :json => {
           :errors => "You can't change this chat"
          }, :status => 403
        end

      end

      def read
        Messages::Status.read(current_user, params[:id])
        render :json => {
           :message => "Chat was marked as read"
          }, :status => 200
      end

      private
        def chat_params
          params.require(:chat).permit(:name, :user_ids => [])
        end

    end
  end
end
