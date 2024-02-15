# frozen_string_literal: true

module Niwa
  # Base plugin module
  module SourcePlugin
    class << self
      private

      def included(base)
        base.extend(::Niwa::SourcePlugin::ClassMethods)
        # base.include(InstanceMethods)
      end
    end

    # Class methods for plugin
    module ClassMethods
      # Dummy implementation
      def filter_files(filenames)
        filenames
      end

      # Handle source files
      def handle_source(filenames)
        filter_files(filenames).flat_map(&@source_handler)
      end

      # Define source handler that's called inside `handle_source` method
      def define_source_handler(&block)
        @source_handler = block
      end

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
    end
  end
end
