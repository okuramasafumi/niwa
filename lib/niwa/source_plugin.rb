# frozen_string_literal: true

module Niwa
  # Base plugin module
  module SourcePlugin
    class << self
      private

      def included(base)
        base.include(::Niwa::SourcePlugin::InstanceMethods)
        base.extend(::Niwa::SourcePlugin::ClassMethods)
      end
    end

    # Methods for plugin
    module InstanceMethods
      def initialize(opts)
        @opts = opts
      end

      # Dummy implementation
      def filter_files(filenames)
        filenames
      end

      # Handle source files
      def handle_source(filenames)
        filter_files(filenames).flat_map(&method(:source_handler))
      end
    end

    # DSL
    module ClassMethods
      # Shortcut to filter rb files
      def rb!
        define_file_filter do |filenames|
          filenames.select { |filename| filename.end_with?('.rb') }
        end
      end

      # DSL to define file filter
      def define_file_filter(&block)
        define_method(:filter_files, &block)
      end

      # Define source handler that's called inside `handle_source` method
      def define_source_handler(&block)
        define_method(:source_handler, &block)
      end
    end
  end
end
