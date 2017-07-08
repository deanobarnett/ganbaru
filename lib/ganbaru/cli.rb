# frozen_string_literal: true
require 'thor'
require 'message_queue'
require 'redis_client'

module Ganbaru
  class Cli < Thor
    desc 'leader DIR', 'Run Ganbaru in Leader Mode'
    option :id, required: true
    option :dir, default: 'spec'
    long_desc <<-LONGDESC
      Run an instance of the Ganbaru test runner.
      This will load the specs that need run into the supplied Redis instance.
    LONGDESC

    def leader
      queue = MessageQueue.new(RedisClient.new, options[:id])
      Ganbaru::Leader.new(queue).run(options[:dir])
    end

    desc 'worker', 'Run Ganbaru in Worker Mode'
    option :id, required: true
    long_desc <<-LONGDESC
      Run an instance of the Ganbaru test runner.
      This will grab and run specs from the queue.
    LONGDESC

    def worker
      queue = MessageQueue.new(RedisClient.new, options[:id])
      Ganbaru::Worker.new(queue).run
    end
  end
end
