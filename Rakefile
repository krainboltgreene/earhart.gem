#!/usr/bin/env rake

require "bundler/gem_tasks"
require "rspec/core/rake_task"

desc "Running all the benchmarks"
task :benchmark do
  STDOUT.puts("Benchmarking:")
  Dir[File.join(File.dirname(__FILE__), "benchmarks", "**", "*.rb")].each do |benchmark|
    STDOUT.puts("---")
    STDOUT.puts(`bundle exec ruby #{benchmark}`.gsub("\t", " ").gsub("--", "__"))
  end
end

desc "Run all profiling tests"
task :profile do
  STDOUT.puts("Profiling:")

  Dir[File.join(File.dirname(__FILE__), "profiles", "**", "*.rb")].each do |profile|
    STDOUT.puts("---")
    STDOUT.puts(`PROFILE_NOTE=true bundle exec ruby #{profile}`.gsub("--", "__"))
  end
end

desc "Note each result in a git-note"
task :record do
  `git notes add -f -m "\`bundle exec rake benchmark profile\`"`
end

desc "Compare current versus last commit"
task :compare do
  system "diff -u <(git notes show) <(bundle exec rake benchmark)"
end

desc "Run all the tests in spec"
RSpec::Core::RakeTask.new(:spec)

desc "Default: run tests"
task default: :spec
