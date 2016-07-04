class CreateJoinTableChatUser < ActiveRecord::Migration[5.0]
  def change
    create_join_table :chats, :users do |t|
      t.index [:chat_id, :user_id], :unique => true
    end
  end
end
