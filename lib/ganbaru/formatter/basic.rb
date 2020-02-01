# frozen_string_literal: true

module Ganbaru
  module Formatter
    class Basic
      def initialize(total)
        @max = total.zero? ? 1 : total
        @count = 0
      end

      def update(_name)
        print '.'
      end

      def add(value = 1)
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
