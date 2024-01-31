# frozen_string_literal: true

require 'niwa'
require 'optparse'

module Niwa
  # Invoked by `niwa` command
  module CLI
    module_function

    # Temporary implementation
    def run(argv)
      options = {}

      ::OptionParser.new do |opts|
        opts.banner = 'Usage: niwa target.rb [options]'

        opts.on('-o', '--output FILE', 'Output file') do |file|
          options[:output] = file
        end
      end.parse! # rubocop:disable Style/MethodCalledOnDoEndBlock

      ::Niwa.plugin(::Niwa::Plugins::YARD)
      ::Niwa.plugin(::Niwa::Plugins::RBS)
      ::Niwa.process(argv, **options)
    end
  end
end
