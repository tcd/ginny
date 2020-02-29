lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "ginny/version"

Gem::Specification.new do |spec|
  spec.name          = "ginny"
  spec.version       = Ginny::VERSION
  spec.required_ruby_version = ">= 2.3.0"
  spec.description   = "Generate Ruby code."
  spec.summary       = spec.description
  spec.authors       = ["Clay Dunston"]
  spec.email         = ["dunstontc@gmail.com"]
  spec.homepage      = "https://github.com/tcd/ginny"
  spec.license       = "MIT"

  spec.metadata = {
    "homepage_uri" => spec.homepage,
    "source_code_uri" => spec.homepage,
    "documentation_uri" => "https://www.rubydoc.info/gems/ginny/#{spec.version}",
    "changelog_uri" => "https://github.com/tcd/ginny/blob/master/CHANGELOG.md",
    "yard.run" => "yri", # use "yard" to build full HTML docs.
  }

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path("..", __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = ["ginny"]
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "coveralls", "~> 0.8.23"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "minitest-focus", "~> 1.1"
  spec.add_development_dependency "minitest-reporters", "~> 1.4"
  spec.add_development_dependency "pry", "~> 0.12.2"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "simplecov"

  spec.add_runtime_dependency "coolkit", "~> 0.2.2"
  spec.add_runtime_dependency "dry-inflector", "~> 0.2.0"
end
