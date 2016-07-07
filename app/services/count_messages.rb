class CountMessages
  def self.count(user_id)
    # Convert to integer if redis not found this record.
    # For example if record just created
    $redis.get("user:#{user_id}:messages").to_i
  end

  def self.inc(user_id)
    $redis.incr "user:#{user_id}:messages"
  end
end
