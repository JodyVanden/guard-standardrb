$LOAD_PATH.unshift('./lib', __FILE__)
require 'guard/standardrb/version'

Gem::Specification.new do |spec|
  spec.name          = "guard-standardrb"
  spec.version       = Guard::StandardrbVersion::VERSION
  spec.authors       = ["Jody Vandenschrick"]
  spec.email         = ["jody.vanden@gmail.com"]

  spec.summary       = %q{add a plugin to guard to work with standardrb.}
  spec.homepage      = "https://github.com/JodyVanden/guard-standardrb"
  spec.license       = "MIT"
  # spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/JodyVanden/guard-standardrb"
  spec.metadata["changelog_uri"] = "https://github.com/JodyVanden/guard-standardrb"

  spec.add_dependency 'guard', '>= 2.0.0'
  spec.add_dependency 'guard-compat', '~> 1.0'
  spec.add_dependency 'standardrb'
  
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec', '~> 3.1'


  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
