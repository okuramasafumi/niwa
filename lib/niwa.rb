# frozen_string_literal: true

using(::Module.new do
  refine(::String) do
    # We need this method here to place it with `upcase`
    def camelize
      split('_').map(&:capitalize).join
    end
  end
end)

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
  def self.plugin(mod_or_name, opts = {})
    mod = case mod_or_name
          when ::Module
            require_relative "niwa/plugins/#{mod_or_name.name.split('::').last.downcase}"
            mod_or_name
          when ::Symbol, ::String
            resolve_mod_name(mod_or_name)
          else
            raise ::Niwa::Error, "Unknown plugin type: #{mod_or_name.class}"
          end
    @plugins << mod.new(opts)
  end

  # Get a plugin class from its name
  def self.resolve_mod_name(name)
    name = name.to_s
    # TODO: Configurable base path
    require_relative "niwa/plugins/#{name.downcase}"
    name_variants = [:camelize, :upcase]
    name_variants.each do |n|
      break ::Niwa::Plugins.const_get(name.__send__(n)) if ::Niwa::Plugins.const_defined?(name.__send__(n))
    end
  end

  # Processes files with registered plugins
  def self.process(filenames, output: 'result.html', plugins: [])
    plugins.each do |plugin_name|
      plugin(plugin_name)
    end

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
