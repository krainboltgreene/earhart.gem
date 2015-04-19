require "benchmark/ips"
require "earhart"
# require "journey"
# require "actiondispatch"
require "lotus/router"
require "usher"

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

  analysis.report("earhart lookup") do
    dispatch = Earhart::Router.new do |router|
      router.map(:accounts) do |endpoint|
        collection(endpoint, :get, Object)
        collection(endpoint, :post, Object)
        member(endpoint, :get, Object)
        member(endpoint, :put, Object)
        member(endpoint, :delete, Object)
      end
    end

    dispatch.routes.find("PUT /accounts/3")
  end

  # I'm fairly sure this isn't how it's supposed to work.
  analysis.report("lotus-router lookup") do
    dispatch = Lotus::Router.new do
      resource "accounts"
    end

    mount = Rack::MockRequest.new(dispatch)

    mount.put("/accounts/3")
  end

  # I was unable to get this to work.
  # analysis.report("usher lookup") do
  #   dispatch = Usher.new(generator: Usher::Util::Generators::URL.new)
  #   dispatch.add_route("/accounts", conditions: { request_method: "GET" }).to(Object)
  #   dispatch.add_route("/accounts", conditions: { request_method: "POST" }).to(Object)
  #   dispatch.add_route("/accounts/:id", conditions: { request_method: "GET" }).to(Object)
  #   dispatch.add_route("/accounts/:id", conditions: { request_method: "PUT" }).to(Object)
  #   dispatch.add_route("/accounts/:id", conditions: { request_method: "DELETE" }).to(Object)
  #   dispatch.recognize_path("PUT /accounts/3")
  # end

  analysis.compare!
end
