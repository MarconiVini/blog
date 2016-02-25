require 'redcarpet'
require 'rouge'
require 'rouge/plugins/redcarpet'
require 'rouge/formatters/html'

module Rouge
  module Plugins
    module Redcarpet
      def rouge_formatter(lexer)
        Formatters::HTML.new(:css_class => "highlight #{lexer.tag}", line_numbers: true)
      end
    end
  end
end

class RedcarpetRenderer < Redcarpet::Render::HTML
  include Rouge::Plugins::Redcarpet
end