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
  def self.process(filenames, output: 'result.html')
    result = @plugins.each_with_object([]) do |plugin, data|
      items = plugin.handle_source(filenames)
      data << items
    end

    registry = registry_from(result)

    ::Niwa::ViewContext.new(registry, output_path: output).render(output_plugin_for(output).template)
  end

  # A mechanism to change output plugin
  def self.output_plugin_for(output)
    ext = ::File.extname(output).tr('.', '')
    case ext
    when 'html'
      ::Niwa::Plugins::DefaultTemplate
    when 'md', 'markdown'
      require_relative 'niwa/plugins/markdown_template'
      ::Niwa::Plugins::MarkdownTemplate
    # We'll add more output plugins soon
    else
      raise ::Niwa::Error, "Unknown output format: #{ext}"
    end
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
