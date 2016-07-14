module Messages

  # Class for manage user's new messages list
  # Use redis and list data type
  # On every chat avery user have list ids of new messages
  class Status

    # Class method: get new messages for user for chat
    # key format: user:#{user_id}:chat:#{chat_id}:new_msg
    # value format: list, ids new messages. For example: [2, 5, 6]
    #
    # user_id - Integer
    # chat_id - Integer
    #
    # Returns Array with messages ids
    def self.get_new(user_id, chat_id)
        $redis.lrange "user:#{user_id}:chat:#{chat_id}:new_msg", 0, -1
    end

    # Class method: mark all messages for user for chat as read
    # key format: user:#{user_id}:chat:#{chat_id}:new_msg
    #
    # user_id - Integer
    # chat_id - Integer
    #
    # Returns Integer: The number of keys that were removed.
    def self.read(user_id, chat_id)
      $redis.del "user:#{user_id}:chat:#{chat_id}:new_msg"
    end

    # Class method: add to every user in chat new message
    # key format: user:#{user_id}:chat:#{chat_id}:new_msg
    #
    # user_ids - Array of Integers - user's id
    # chat_id - Integer
    # message_id - Integer
    #
    # Returns Integer: count message recivers
    def self.send_to_all(users_ids, chat_id, message_id)
      users_ids.each do |user_id|
        $redis.rpush "user:#{user_id}:chat:#{chat_id}:new_msg", message_id
      end
      users_ids.count
    end
  end

end
