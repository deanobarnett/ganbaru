# frozen_string_literal: true
require 'redis_client'

module Ganbaru
  class Leader
    def initialize(queue:)
      @queue = queue
    end

    def run(dir)
      spec_files = Dir.glob("#{dir}/**/*_spec.rb")
      @queue.push(spec_files).tap do
        puts "Loaded #{spec_files.size} tests to run."
        puts "Test ID: #{@queue.id}"
      end
    end
  end
end
