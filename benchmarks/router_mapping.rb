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

  analysis.report("Router Mapping") do
    Earhart::Router.new do |router|
      router.map(:accounts) do |endpoint|
        collection(endpoint, :get, Object)
        collection(endpoint, :post, Object)
        member(endpoint, :get, Object)
        member(endpoint, :put, Object)
        member(endpoint, :delete, Object)
      end
    end
  end
end
