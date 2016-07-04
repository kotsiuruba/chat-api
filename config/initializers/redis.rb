$redis = Redis::Namespace.new("chat_api", :redis => Redis.new)
