# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'stable-rails/version'

Gem::Specification.new do |gem|
  gem.name          = "stable-rails"
  gem.version       = Stable::Rails::VERSION
  gem.authors       = ["Martin Scebba", "Brian J. Cardiff"]
  gem.email         = ["mscebba@manas.com.ar", "bcardiff@manas.com.ar"]
  gem.description   = %q{Scrollable table with fixed first row and column.}
  gem.summary       = %q{Rails gem that allows to easily include scrollable tables.}
  gem.homepage      = "https://github.com/manastech/stable-rails"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_runtime_dependency 'haml-rails'
end
