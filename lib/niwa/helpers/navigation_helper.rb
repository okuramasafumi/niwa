# frozen_string_literal: true

module Niwa
  module Helpers
    # Helper for rendering navigation
    module NavigationHelper
      # Render tree from navigation
      # rubocop:disable Metrics/MethodLength
      def render_tree(node, id = '0')
        return '' if node.leaf?

        html = "<ul class='list-group #{'collapse' unless id == '0'}' id='node-#{id}'>\n"
        index = 0
        node.each do |child|
          unless child.leaf?
            id = "#{id}-#{index}"
            html << "<li class='list-group-item'>\n"
            html << <<BUTTON
          <button type="button" data-bs-toggle="collapse" data-bs-target="#node-#{id}" aria-expanded="false" aria-controls="node-#{id}">
            <svg xmlns="http://www.w3.org/2000/svg" width="8" height="8" fill="currentColor" class="bi bi-caret-down-fill" viewBox="0 0 16 16">
              <path d="M7.247 11.14 2.451 5.658C1.885 5.013 2.345 4 3.204 4h9.592a1 1 0 0 1 .753 1.659l-4.796 5.48a1 1 0 0 1-1.506 0z"/>
            </svg>
          </button>
BUTTON
          end
          if child.leaf?
            html << "<a href='#niwa-item-#{child.item.id}'>#{child}</a>\n"
          else
            html << "<span>#{child}</span>\n"
            html << render_tree(child, id)
            html << "</li>\n"
          end
          index += 1
        end
        html << "</ul>\n"
        html
      end
      # rubocop:enable Metrics/MethodLength
    end
  end
end
