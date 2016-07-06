class UserToken

  def self.generate(user_id)

    begin
      token = SecureRandom.hex
    end while $redis.get "user_token:#{token}"
    # write token to redis
    $redis.set "user_token:#{token}", user_id
    # return token value
    token

  end

  def self.get_user_id(token)
    $redis.get "user_token:#{token}"
  end

end
