# frozen_string_literal: true

require 'erb'
require_relative 'navigation'
require_relative 'helpers/navigation_helper'
require_relative 'helpers/main_helper'

module Niwa
  # A context object to render view template
  class ViewContext
    include ::Niwa::Helpers::NavigationHelper
    include ::Niwa::Helpers::MainHelper

    attr_reader :registry, :navigation

    def initialize(registry, output_path: 'result.html')
      @registry = registry
      @output_path = output_path
      @navigation = navigation_from(registry)
    end

    # Render HTML file
    # `sample.html` is a temporary value
    def render(template)
      ::File.write(@output_path, ::ERB.new(template).result(binding))
    end

    private

    def navigation_from(registry)
      ::Niwa::Navigation.new(registry).render
    end
  end
end
