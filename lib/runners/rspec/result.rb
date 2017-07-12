# frozen_string_literal: true
module Runners
  module Rspec
    class Result
      def initialize(result)
        @result = JSON.parse(result.gsub('=>', ':'))
      end

      def failed?
        @result['summary']['failure_count'].positive? ||
          @result['summary']['example_count'].zero?
      end

      def to_h
        @result
      end
    end

    class NullResult
      def failed?
        false
      end

      def to_h
        {}
      end
    end
  end
end
