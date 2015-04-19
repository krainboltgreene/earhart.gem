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
  Earhart::Route.new(%r|GET /person/#{id}|, Object)
end

def generate_routes(count)
  Earhart::Routes.new(count.times.map { |index| generate_route(index) })
end

def path(size)
  "GET /person/#{rand(1..size)}"
end

SMALL_SIZE = 10
SMALL_DATA = generate_routes(10)

BIG_SIZE = 200
BIG_DATA = generate_routes(200)


Benchmark.ips do |analysis|
  analysis.time = 5
  analysis.warmup = 2

  analysis.report("small (#{SMALL_SIZE})") do
    SMALL_DATA.find(path(BIG_SIZE))
  end

  analysis.report("big (#{BIG_SIZE})") do
    BIG_DATA.find(path(BIG_SIZE))
  end
end
