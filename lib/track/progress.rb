# frozen_string_literal: true

require 'ganbaru/formatter'

module Track
  class Progress
    attr_reader :remaining

    def initialize(queue:, formatter:)
      @queue = queue
      @remaining = queue.size
      @formatter = Ganbaru::Formatter.for(formatter).new(@remaining)
    end

    def update
      new_remaining = @queue.size
      @formatter.add(@remaining - new_remaining)
      @remaining = new_remaining
    end
  end
end
