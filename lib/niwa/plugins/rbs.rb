# frozen_string_literal: true

require 'rbs'
require_relative '../source_plugin'

module Niwa
  module Plugins
    # Inline RBS plugin
    class RBS
      include ::Niwa::Plugins::Comment
      # Extending Visitor class to handle RBS
      class Visitor < ::Niwa::Plugins::Comment::Visitor
        def initialize
          @plugin_name = 'Niwa::Plugins::RBS'
          super
        end

        private

        # rubocop:disable Metrics/MethodLength
        def metadata_from(comments)
          ary = []
          comments.each do |comment|
            parse_result = ::RBS::Parser.parse_method_type(comment.value.delete_prefix('# '))
            next if parse_result.nil?

            type = parse_result.type
            ary << ['param', type.param_to_s]
            ary << ['return', type.return_to_s]
          rescue ::RBS::ParsingError
            nil
          end
          ary.to_h
        end
        # rubocop:enable Metrics/MethodLength
      end
    end
  end
end
