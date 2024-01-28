# frozen_string_literal: true

require_relative 'niwa/version'
require_relative 'niwa/entity'
require_relative 'niwa/view_context'
require_relative 'niwa/plugins/comment'
require_relative 'niwa/plugins/rbs'
require_relative 'niwa/plugins/yard'
require_relative 'niwa/plugins/default_template'

# Niwa module is a base namespace.
# It has `plugin` method that registers plugins.
module Niwa
  class Error < StandardError; end

  @plugins = []

  # Registers a plugin
  # Currently `mod` should be a module
  def self.plugin(mod)
    @plugins << mod
  end

  # Processes files with registered plugins
  def self.process(filenames)
    result = @plugins.each_with_object([]) do |plugin, data|
      items = plugin.handle_source(filenames)
      data << items
    end

    registry = registry_from(result)

    ::Niwa::ViewContext.new(registry).render(active_html_plugin.template)
  end

  # A mechanism to change HTML plugin
  # Currently it's just a stub
  def self.active_html_plugin
    ::Niwa::Plugins::DefaultTemplate
  end

  # This should be a private method
  def self.registry_from(result)
    result.each_with_object([]) do |items, reg|
      items.each do |item|
        reg << item
      end
      reg
    end
  end
end
