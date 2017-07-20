# frozen_string_literal: true
module Runners
  module Rspec
    class Result
      def initialize(result)
        @result = JSON.parse(result.gsub('=>', ':'))
      end

      def failed?
        return false if empty?
        @result['summary']['failure_count'].positive? ||
          @result['summary']['example_count'].zero?
      end

      def to_h
        @result
      end

      private

      def empty?
        return true if @result["examples"].nil?
        @result["examples"].empty?
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
