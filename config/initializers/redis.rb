if ENV["REDISCLOUD_URL"]
  $redis_instance = Redis.new(:url => ENV["REDISCLOUD_URL"])
else
  $redis_instance = Redis.new
end
$redis = Redis::Namespace.new("chat_api", :redis => $redis_instance)
