#!/usr/bin/env ruby

lib = File.expand_path(File.join("..", "lib"), __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "earhart/version"

Gem::Specification.new do |spec|
  spec.name = "earhart"
  spec.version = Earhart::VERSION
  spec.authors = ["Kurtis Rainbolt-Greene"]
  spec.email = ["me@kurtisrainboltgreene.name"]
  spec.summary = %q{A pure ruby HTTP router}
  spec.description = spec.summary
  spec.homepage = "http://krainboltgreene.github.io/earhart"
  spec.license = "MIT"

  spec.files = Dir[File.join("lib", "**", "*")]
  spec.executables = Dir[File.join("bin", "**", "*")].map! { |f| f.gsub(/bin\//, "") }
  spec.test_files = Dir[File.join("test", "**", "*"), File.join("spec", "**", "*")]
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "hamster", "~> 1.0"
  spec.add_runtime_dependency "scrawl", "~> 3.0"

  spec.add_development_dependency "benchmark-ips", "~> 2.1.1"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rake", "~> 10.1"
  spec.add_development_dependency "pry", "~> 0.9"
  spec.add_development_dependency "pry-doc", "~> 0.6"
  spec.add_development_dependency "codeclimate-test-reporter", "~> 0.4"
  spec.add_development_dependency "ruby-prof"
end
