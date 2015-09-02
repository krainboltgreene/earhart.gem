require "benchmark/ips"
require "earhart"

puts ""
puts "OS Name: #{`uname -a`}"
puts `sw_vers`
puts "Ruby Version: #{`ruby -v`}"
puts "RubyGems Version: #{`gem -v`}"
puts "RVM Version: #{`rvm -v`}"
puts ""

Benchmark::IPS.options[:format] = :raw

Benchmark.ips do |analysis|
  analysis.time = 5
  analysis.warmup = 2
  analysis.compare!

  analysis.report("One map") do
    Earhart::Router.new do |router|
      router.collection(verb: :get, resource: :accounts, receiver: Object)
    end
  end

  analysis.report("Two maps") do
    Earhart::Router.new do |router|
      router.collection(verb: :get, resource: :accounts, receiver: Object)
      router.collection(verb: :put, resource: :accounts, receiver: Object)
    end
  end

  analysis.report("Three maps") do
    Earhart::Router.new do |router|
      router.collection(verb: :get, resource: :accounts, receiver: Object)
      router.collection(verb: :put, resource: :accounts, receiver: Object)
      router.collection(verb: :pull, resource: :accounts, receiver: Object)
    end
  end
end
