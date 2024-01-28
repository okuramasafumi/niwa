# frozen_string_literal: true

module Niwa
  # Base class for HTML representation plugin
  module HTMLPlugin
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
