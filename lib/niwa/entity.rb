# frozen_string_literal: true

module Niwa
  # Entity is generated from source code, comments and any other data source
  class Entity
    attr_accessor :klass, :name, :metadata, :filename, :plugin_name, :code

    def initialize(klass:, name:, filename: nil, metadata: {}, plugin_name: nil, code: nil) # rubocop:disable Metrics/ParameterLists
      @klass = klass
      @name = name
      @filename = filename
      @metadata = metadata
      @plugin_name = plugin_name
      @code = code
    end

    # Unique ID for each entity
    def id
      "#{@klass.hash}-#{@name.hash}-#{@plugin_name.hash}"
    end

    # Comparison, when two entities are equal, they will be merged
    def ==(other)
      @filename == other.filename && @klass == other.klass && @name == other.name
    end

    # Merge two entities and create new one
    def merge(other)
      self.class.new(klass: @klass, name: @name, filename: @filename, metadata: @metadata.merge(other.metadata))
    end
  end
end
