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

def generate_route(id)
  Earhart::Route.new(Earhart::Pattern.new(verb: "GET", resource: "/persons/#{id}"), Object)
end

def generate_routes(count)
  Earhart::Routes.new(count.times.map { |index| generate_route(index) })
end

def path(size)
  "verb=\"GET\" resource=\"/persons/#{rand(1..size)}\""
end

SMALL_SIZE = 10
SMALL_DATA = generate_routes(SMALL_SIZE)

BIG_SIZE = 1000
BIG_DATA = generate_routes(BIG_SIZE)

Benchmark.ips do |analysis|
  analysis.time = 5
  analysis.warmup = 2
  analysis.compare!

  analysis.report("Small (#{SMALL_SIZE})") do
    SMALL_DATA.find(path(SMALL_SIZE / 2))
  end

  analysis.report("Big (#{BIG_SIZE})") do
    BIG_DATA.find(path(BIG_SIZE / 2))
  end
end
