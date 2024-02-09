# frozen_string_literal: true

require 'niwa'
require 'optparse'

module Niwa
  # Invoked by `niwa` command
  module CLI
    module_function

    # Temporary implementation
    def run(argv) # rubocop:disable Metrics/MethodLength
      options = {}

      ::OptionParser.new do |opts|
        opts.banner = 'Usage: niwa target.rb [options]'

        opts.on('-o', '--output FILE', 'Output file') do |file|
          options[:output] = file
        end

        opts.on('--plugins foo,bar', ::Array, 'Plugins') do |comma_separated_plugin_names|
          options[:plugins] = comma_separated_plugin_names
        end
      end.parse! # rubocop:disable Style/MethodCalledOnDoEndBlock

      ::Niwa.process(argv, **options)
    end
  end
end
