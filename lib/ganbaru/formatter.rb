# frozen_string_literal: true

require 'active_support/core_ext/string'

require 'ganbaru/formatter/silent'
require 'ganbaru/formatter/basic'
require 'ganbaru/formatter/named'
require 'ganbaru/formatter/progress_bar'

module Ganbaru
  module Formatter
    def self.for(name)
      "Ganbaru::Formatter::#{name.classify}".constantize
    rescue NameError
      raise ArgumentError, "Unsupported formatter: '#{name}'"
    end
  end
end
