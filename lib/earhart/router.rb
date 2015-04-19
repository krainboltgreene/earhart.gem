module Earhart
  class Router
    def initialize
      @routes = Earhart::Routes.new

      yield(self)
    end

    def collection(endpoint, verb, receiver)
      @routes.add(Route.new(%r|#{verb.upcase} /#{endpoint}/|, receiver))
    end

    def member(endpoint, verb, receiver)
      @routes.add(Route.new(%r|#{verb.upcase} /#{endpoint}/(?<id>.+)|, receiver))
    end

    def map(resource, &block)
      instance_exec(resource, &block)
    end

    def lookup(request)
      @routes.find(request.to_s).receiver
    end
  end
end
