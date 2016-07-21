# frozen_string_literal: true
require 'redis'

class RedisClient
  def self.new
    Redis.new(url: ENV['REDIS_URL'])
  end
end
