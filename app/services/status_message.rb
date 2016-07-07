class StatusMessage
  def self.get_new(user_id, chat_id)
    message_ids = $redis.lrange "user:#{user_id}:chat:#{chat_id}:new_msg", 0, 1
    Message.where(:id => message_ids)
  end

  def self.read(user_id, chat_id)
    $redis.del "user:#{user_id}:chat:#{chat_id}:new_msg"
  end

  def self.send_to_all(users_ids, chat_id, message_id)
    users_ids.each do |user_id|
      $redis.rpush "user:#{user_id}:chat:#{chat_id}:new_msg", message_id
    end
  end
end
