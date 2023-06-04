# frozen_string_literal: true

require_relative "lib/niwa/version"

Gem::Specification.new do |spec|
  spec.name = "niwa"
  spec.version = Niwa::VERSION
  spec.authors = ["OKURA Masafumi"]
  spec.email = ["masafumi.o1988@gmail.com"]

  spec.summary = "New, Integrated, Working Annotations"
  spec.description = "New, Integrated, Working Annotations"
  spec.homepage = "https://github.com/okuramasafumi/niwa"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/okuramasafumi/niwa"
  spec.metadata["changelog_uri"] = "https://github.com/okuramasafumi/niwa/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) || f.start_with?(*%w[bin/ test/ spec/ features/ .git .circleci appveyor])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
