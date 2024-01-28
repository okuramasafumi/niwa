# frozen_string_literal: true

require 'niwa'

module Niwa
  # Invoked by `niwa` command
  module CLI
    module_function

    # Temporary implementation
    def run(argv)
      ::Niwa.plugin(::Niwa::Plugins::YARD)
      ::Niwa.plugin(::Niwa::Plugins::RBS)
      ::Niwa.process(argv)
    end
  end
end
