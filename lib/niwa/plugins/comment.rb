# frozen_string_literal: true

require_relative '../source_plugin'
require 'syntax_tree'

module Niwa
  module Plugins
    # Plugin to get comment from source code
    module Comment
      class << self
        private

        # rubocop:disable Metrics/MethodLength
        def included(base)
          base.include(::Niwa::SourcePlugin)
          base.class_eval do
            rb!

            define_source_handler do |filename|
              visitor.visit(::SyntaxTree.parse(::SyntaxTree.read(filename)))
              visitor.result.map do |item|
                item.filename = filename
                item
              end
            end

            # Get visitor object for current plugin
            def self.visitor
              @visitor ||= ::Object.const_get("#{name}::Visitor").new
            end
          end
        end
        # rubocop:enable Metrics/MethodLength
      end

      # Visitor class to get comment information from source code
      class Visitor < ::SyntaxTree::Visitor
        attr_reader :result

        def initialize
          super
          @result = []
          @class = nil
        end

        # rubocop:disable Metrics
        visit_methods do
          # Get comments from statement node
          def visit_statements(node)
            if node.child_nodes.any? { _1.instance_of?(::SyntaxTree::DefNode) }
              comments = []
              node.child_nodes.each do |n|
                case n
                when ::SyntaxTree::Comment
                  comments << n
                when ::SyntaxTree::DefNode
                  @result << ::Niwa::Entity.new(
                    klass: @class,
                    name: n.name.value,
                    metadata: metadata_from(comments),
                    plugin_name: @plugin_name,
                    code: nil
                  ) # TODO: get code body
                  comments = []
                else
                  next
                end
              end
            elsif (class_node = node.child_nodes.find { |n| n.instance_of?(::SyntaxTree::ClassDeclaration) })
              @class = "#{@class}::#{class_node.constant.constant.value}"
              @result.each { |item| item.klass = @class if item.klass.nil? }
            end

            super
          end
        end
        # rubocop:enable Metrics

        private

        def metadata_from(comments)
          # For override
          {comments: comments}
        end
      end
    end
  end
end
