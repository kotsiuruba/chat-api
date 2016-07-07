module Api
  module V1
    class MessagesController < ApplicationController
      before_action :authenticate

      def index
        render :json => Message
        .joins(:user)
        .where("users.id" => current_user, :chat_id => params[:chat_id])
        .all
      end

      def create
        chat = Chat
        .joins(:users)
        .where("users.id" => current_user, :id => params[:chat_id])
        .first
        if !chat.nil?
          message = Message.create(
            :content => params[:message][:content],
            :user_id => current_user,
            :chat_id => params[:chat_id]
          )

          if message.persisted?
            StatusMessage.send_to_all(chat.users.pluck(:id), chat.id, message.id)
            render :json => message
          else
            render :json => {
              :errors => chat.errors.full_messages
            }, :status => 422
          end

        else
          render :json => {
           :errors => "You can't write message in this chat"
          }, :status => 403
        end
      end

      def new
        render :json => StatusMessage.get_new(current_user, params[:chat_id])
      end

      private
        def message_params
          params.require(:message).permit(:content)
        end
    end
  end
end
