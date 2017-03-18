# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rails_admin_robots_txt/version'

Gem::Specification.new do |spec|
  spec.name          = "rails_admin_robots_txt"
  spec.version       = RailsAdminRobotsTxt::VERSION
  spec.authors       = ["Alexander Kiseliev"]
  spec.email         = ["i43ack@gmail.com"]

  spec.summary       = %q{robots.txt editor in rails_admin panel}
  spec.description   = %q{robots.txt editor in rails_admin panel}
  spec.homepage      = "https://github.com/ack43/rails_admin_robots_txt"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.8"
  spec.add_development_dependency "rake", "~> 10.0"

  spec.add_dependency "rails_admin", '>= 0.8.1'
end
