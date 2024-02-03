# frozen_string_literal: true

require_relative '../output_plugin'

module Niwa
  module Plugins
    # Default template plugin
    # If there's no view plugin applied, this one is used
    class DefaultTemplate
      include ::Niwa::OutputPlugin

      template_path 'templates/index.html.erb'
    end
  end
end
