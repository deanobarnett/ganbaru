# frozen_string_literal: true
module Runners
  module Rspec
    class Result
      def initialize(result, specs)
        @specs = specs
        @result = JSON.parse(result.gsub('=>', ':'))
      end

      def failed?
        return false if empty?
        @result['summary']['failure_count'].positive? ||
          @result['summary']['example_count'].zero?
      end

      def examples
        @result['examples']
      end

      def to_h
        @result.merge('files' => @specs)
      end

      private

      def empty?
        return true if @result["examples"].nil?
        @result["examples"].empty?
      end
    end
  end
end
