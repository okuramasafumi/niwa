# frozen_string_literal: true

module Niwa
  # Base class for HTML representation plugin
  module OutputPlugin
    class << self
      private

      def included(base)
        base.extend(::Niwa::OutputPlugin::ClassMethods)
      end
    end

    # DSL for output plugins
    module ClassMethods
      # Set path for template
      def template_path(path)
        @template_path = path
      end

      # Return template content
      def template
        ::File.read(@template_path)
      end
    end
  end
end
