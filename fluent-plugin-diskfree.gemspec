# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name          = "fluent-plugin-diskfree"
  spec.version       = '0.1.3'
  spec.authors       = ["h.nomura"]
  spec.email         = ["h.nomura0504@gmail.com"]

  spec.summary       = "execute linux df command plugin for fluent."
  spec.description   = "execute linux df command plugin for fluent."
  spec.homepage      = "https://github.com/nomunomu0504/fluent-plugin-diskfree"
  spec.license       = "MIT"
  spec.required_ruby_version = ">= 2.5.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/nomunomu0504/fluent-plugin-diskfree"
  spec.metadata["changelog_uri"] = "https://github.com/nomunomu0504/fluent-plugin-diskfree/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"
  spec.add_dependency "fluentd", ">= 1.3", "< 2"
  spec.add_development_dependency "bundler", "~> 2.2.23"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rubocop", "~> 1.18.3"
  spec.add_development_dependency "test-unit"
  spec.add_development_dependency "rspec"

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
end
