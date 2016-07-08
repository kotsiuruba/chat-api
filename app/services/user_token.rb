# Class for generete, set and find user's token
class UserToken

  # Class method: write to redis storage user id whit token as key
  # key format: user_token:token_string
  # value format: integer, user id
  #
  # user_id - Integer to be saved
  #
  # Returns String - generated token
  def self.generate(user_id)

    begin
      token = SecureRandom.hex
    end while $redis.get "user_token:#{token}"
    # write token to redis
    $redis.set "user_token:#{token}", user_id
    # return token value
    token

  end


  # Class method: get user id from redis storage by token key
  # key format: user_token:token_string
  #
  # token - String used for key
  #
  # Returns Integer - user id
  def self.get_user_id(token)
    $redis.get("user_token:#{token}").to_i
  end

end
