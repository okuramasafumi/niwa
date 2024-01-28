# frozen_string_literal: true

require_relative '../html_plugin'

module Niwa
  module Plugins
    # Default template plugin
    # If there's no view plugin applied, this one is used
    class DefaultTemplate
      extend ::Niwa::HTMLPlugin

      template_path 'templates/index.html.erb'
    end
  end
end
