# frozen_string_literal: true

require 'tree_support'

module Niwa
  # Namespace for navigation
  class Navigation
    # Represents a node for navigation
    class Node
      attr_reader :parent, :children, :item

      def initialize(parent, children = [], item = nil)
        @parent = parent
        @children = children
        @item = item
      end

      # Iterate over children
      def each(&block)
        @children.each(&block)
      end

      # Returns whether the node is a leaf
      def leaf?
        @children.empty?
      end

      # Returns the name of the node
      def to_s
        return 'Root' if @parent.nil?

        if item&.name
          item.name
        elsif item&.klass
          item.klass
        else
          'Unknown'
        end
      end
    end

    def initialize(registry)
      @registry = registry
      @root_node = ::Niwa::Navigation::Node.new(nil)
    end

    # Render the navigation
    def render
      @registry.each do |entity|
        find_or_create_nodes(entity)
      end
      puts(::TreeSupport.tree(@root_node))
      @root_node
    end

    private

    # rubocop:disable Metrics/MethodLength
    # rubocop:disable Metrics/AbcSize
    def find_or_create_nodes(entity)
      target = @root_node
      namespaces = entity.klass.delete_prefix('::').split('::')
      namespaces.each.with_index(1) do |name, idx|
        node = target.children.find { |c| c.item.klass == name }
        if node.nil?
          node = ::Niwa::Navigation::Node.new(target, [], ::Niwa::Entity.new(klass: name, name: nil))
          target.children << node
        end
        target = node
        target.children << ::Niwa::Navigation::Node.new(target, [], entity) if idx == namespaces.size
        target
      end
    end
    # rubocop:enable Metrics/MethodLength
    # rubocop:enable Metrics/AbcSize
  end
end
