# frozen_string_literal: true

module Ganbaru
  module Formatter
    class Named
      def initialize(total)
        @max = total.zero? ? 1 : total
        @count = 0
      end

      def update(name)
        puts name
      end

      def add(value)
        @count = @count + value
      end

      def progress
        @count
      end

      def remaining
        @max - @count
      end
    end
  end
end
