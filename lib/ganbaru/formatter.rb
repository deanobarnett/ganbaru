# frozen_string_literal: true

require 'ganbaru/formatter/silent'
require 'ganbaru/formatter/basic'
require 'ganbaru/formatter/progress_bar'

module Ganbaru
  module Formatter
    def self.for(name)
      "Ganbaru::Formatter::#{name}".split('::')
                                   .inject(Object) do |mod, class_name|
          mod.const_get(class_name.capitalize)
      end
    rescue NameError
      raise ArgumentError, "Unsupported formatter: '#{name}'"
    end
  end
end
