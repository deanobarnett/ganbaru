# frozen_string_literal: true

require 'redis_client'

module Ganbaru
  class Leader
    def initialize(queue:)
      @queue = queue
    end

    def run(dir)
      puts "Test ID: #{@queue.id}"
      puts "Scanning #{dir}..."

      spec_files = Dir.glob("#{dir}/**/*_spec.rb")
      puts "There are #{spec_files.size} files."

      if spec_files.empty?
        puts "No spec files found under '#{dir}'."
        0
      else
        @queue.push(spec_files).tap do
          puts "Loaded #{spec_files.size} tests to run."
        end
      end
    end
  end
end
