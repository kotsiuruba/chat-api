class UserToken

  def self.generate(user_id)

    begin
      token = SecureRandom.hex
    end while $redis.get "user_token:#{token}"
    # write token to redis with expire time 7 deys
    $redis.set "user_token:#{token}", user_id, :ex => 60*60*24*7
    # return token value
    token

  end

  def self.get_user_id(token)
    $redis.get "user_token:#{token}"
  end

end
