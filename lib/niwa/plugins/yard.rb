# frozen_string_literal: true

require 'yard'
require_relative '../plugin'

module Niwa
  module Plugins
    # YARD plugin
    class YARD
      include ::Niwa::Plugins::Comment

      # Extending Visitor class  to handle YARD tags
      class Visitor < ::Niwa::Plugins::Comment::Visitor
        def initialize
          @plugin_name = 'Niwa::Plugins::YARD'
          super
        end

        private

        # rubocop:disable Metrics/MethodLength
        def metadata_from(comments)
          ary = comments.filter_map do |comment|
            tags = ::YARD::DocstringParser.new.parse(comment.value.delete_prefix('# ')).to_docstring.tags
            tag = tags.first
            case tag&.tag_name
            when 'return'
              ['return', tag.types]
            when 'param'
              ['param', tag.types]
            else # rubocop:disable Style/EmptyElse
              # TODO: Implement other tags
              nil
            end
          end
          ary.to_h
        end
        # rubocop:enable Metrics/MethodLength
      end
    end
  end
end
