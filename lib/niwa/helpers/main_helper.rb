# frozen_string_literal: true

module Niwa
  module Helpers
    # Helper to render main component
    module MainHelper
      # Render tree from navigation
      def render_main(registry, template_path: 'templates/main.html.erb')
        ::ERB.new(::File.read(template_path)).result_with_hash(registry: registry)
      end
    end
  end
end
