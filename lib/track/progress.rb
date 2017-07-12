# frozen_string_literal: true
require 'formatter/basic'

module Track
  class Progress
    attr_reader :remaining

    def initialize(queue)
      @queue = queue
      @remaining = queue.size
      @formatter = Formatter::Basic.new(@remaining)
    end

    def update
      new_remaining = @queue.size
      @formatter.add(@remaining - new_remaining)
      @remaining = new_remaining
    end
  end
end
