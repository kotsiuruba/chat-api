module Messages

  # Class for counting message by user and storage them in redis
  class Counter

    # Class method: get count user's messages
    # key format: user:#{user_id}:messages
    # value format: integer, count messages
    #
    # user_id - Integer
    #
    # Returns Integer - count user's messages
    def self.count(user_id)
      # Convert to integer if redis not found this record.
      # For example if record just created
      $redis.get("user:#{user_id}:messages").to_i
    end

    # Class method: increments count user's messages
    # key format: user:#{user_id}:messages
    # value format: integer, count messages
    #
    # user_id - Integer
    #
    # Returns Integer - count user's messages
    def self.inc(user_id)
      $redis.incr "user:#{user_id}:messages"
    end
  end

end
