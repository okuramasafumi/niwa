# frozen_string_literal: true

module Niwa
  module Plugins
    # Markdown plugin outputs the document as markdown
    class MarkdownTemplate
      include ::Niwa::OutputPlugin

      template_path 'templates/index.md.erb'
    end
  end
end
