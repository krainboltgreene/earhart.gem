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

EarhartTestRouter = Earhart::Router.new do |router|
  router.collection(verb: :post, resource: :accounts, receiver: Object)
  router.collection(verb: :get, resource: :accounts, receiver: Object)
  router.member(verb: :get, resource: :accounts, receiver: Object)
  router.member(verb: :put, resource: :accounts, receiver: Object)
  router.member(verb: :delete, resource: :accounts, receiver: Object)
end

LotusTestRouter = Lotus::Router.new do
  resource "accounts"
end

LotusRouterRack = Rack::MockRequest.new(LotusTestRouter)

Benchmark.ips do |analysis|
  analysis.time = 5
  analysis.warmup = 2

  analysis.report("earhart lookup") do
    EarhartTestRouter.lookup(request: "verb=\"PUT\" resource=\"/accounts/3\"")
  end

  # I'm fairly sure this isn't how it's supposed to work.
  analysis.report("lotus-router lookup") do
    LotusRouterRack.put("/accounts/3")
  end

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
