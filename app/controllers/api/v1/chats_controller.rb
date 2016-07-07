module Api
  module V1
    class ChatsController < ApplicationController
      before_action :authenticate#, :except => :create

      def create
        chat = Chat.create(chat_params)
        if chat.persisted?
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
        if chat.users.include? curent_user_obj
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

        # alternative implementation
        # chat = Chat
        # .joins(:users)
        # .where("users.id" => current_user, :id => params[:id])
        # .first
        # if !chat.nil?
        # else
        # end

      end

      def read

      end

      private
        def chat_params
          params.require(:chat).permit(:name, :user_ids => [])
        end

    end
  end
end
