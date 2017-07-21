# frozen_string_literal: true
require 'thor'
require 'message_queue'
require 'redis_client'
require 'track/metrics'

module Ganbaru
  class Cli < Thor
    desc 'leader DIR', 'Run Ganbaru in Leader Mode'
    option :id, required: true
    option :dir, default: 'spec'
    option :shuffle, default: false
    long_desc <<-LONGDESC
      Run an instance of the Ganbaru test runner.
      This will load the specs that need run into the supplied Redis instance.
    LONGDESC

    def leader
      Ganbaru::Leader.new(queue: queue).run(options[:dir], shuffle: options[:shuffle])
    end

    desc 'worker', 'Run Ganbaru in Worker Mode'
    option :id, required: true
    option :formatter, default: 'progress_bar'
    long_desc <<-LONGDESC
      Run an instance of the Ganbaru test runner.
      This will grab and run specs from the queue.
    LONGDESC

    def worker
      Track::Metrics.worker(options[:id])
      Ganbaru::Worker.new(queue: queue, formatter: options[:formatter]).run
    end

    private

    def queue
      MessageQueue.new(RedisClient.new, options[:id])
    end
  end
end
