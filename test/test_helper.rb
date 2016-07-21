# frozen_string_literal: true
require 'simplecov'
SimpleCov.start do
  add_filter '/test/'
  add_filter '/spec/'
end

require 'minitest/autorun'
require 'minitest/pride'
