module Niwa
  module Plugins
    class MarkdownTemplate
      include ::Niwa::OutputPlugin

      template_path 'templates/index.md.erb'
    end
  end
end
